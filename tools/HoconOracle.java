import com.typesafe.config.*;
import java.io.*;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.StandardCharsets;
import java.util.*;

// Original JSON-lines adapter around the unmodified upstream library.
class HoconOracle {
  static final ConfigRenderOptions RENDER=ConfigRenderOptions.concise();
  static class MemoryIncludes implements ConfigIncluder, ConfigIncluderFile, ConfigIncluderURL, ConfigIncluderClasspath {
    final Map<String,String> sources;
    MemoryIncludes(Map<String,String> sources){this.sources=sources;}
    public ConfigIncluder withFallback(ConfigIncluder fallback){return this;}
    public ConfigObject include(ConfigIncludeContext context,String name){
      String source=sources.get(name);
      if(source==null){if(!context.parseOptions().getAllowMissing())throw new ConfigException.Generic("missing include "+name);return ConfigFactory.empty().root();}
      return ConfigFactory.parseString(source,context.parseOptions().setIncluder(this).setOriginDescription(name)).root();
    }
    public ConfigObject includeFile(ConfigIncludeContext c,File f){return include(c,f.getPath());}
    public ConfigObject includeURL(ConfigIncludeContext c,URL u){return include(c,u.toString());}
    public ConfigObject includeResources(ConfigIncludeContext c,String s){return include(c,s);}
  }
  static class Environment implements ConfigResolver {
    final Map<String,String> values;final ConfigResolver fallback;
    Environment(Map<String,String> values,ConfigResolver fallback){this.values=values;this.fallback=fallback;}
    public ConfigValue lookup(String path){String v=values.get(String.join(".",ConfigUtil.splitPath(path)));return v!=null?ConfigValueFactory.fromAnyRef(v):fallback==null?null:fallback.lookup(path);}
    public ConfigResolver withFallback(ConfigResolver r){return new Environment(values,r);}
  }
  static Map<String,String> strings(Config c,String key){Map<String,String> out=new HashMap<>();if(c.hasPath(key))for(var e:c.getObject(key).entrySet())out.put(e.getKey(),String.valueOf(e.getValue().unwrapped()));return out;}
  static Config fromURL(String url,ConfigParseOptions options){try{return ConfigFactory.parseURL(new URL(url),options);}catch(java.net.MalformedURLException e){throw new IllegalArgumentException(e);}}
  static Object getter(Config config,Config req){
    String kind=req.getString("getter"),path=req.getString("path");
    return switch(kind){
      case "string" -> config.getString(path);
      case "boolean" -> config.getBoolean(path);
      case "int" -> config.getInt(path);
      case "long" -> Long.toString(config.getLong(path));
      case "double" -> {double d=config.getDouble(path);yield Double.isFinite(d)?d:Double.toString(d);}
      case "duration" -> Long.toString(config.getDuration(path).toNanos());
      case "bytes" -> Long.toString(config.getBytes(path));
      case "memory" -> config.getMemorySize(path).toBytesBigInteger().toString();
      case "string-list" -> config.getStringList(path);
      case "boolean-list" -> config.getBooleanList(path);
      case "int-list" -> config.getIntList(path);
      case "long-list" -> config.getLongList(path).stream().map(Object::toString).toList();
      case "double-list" -> config.getDoubleList(path).stream().map(d -> Double.isFinite(d)?(Object)d:Double.toString(d)).toList();
      case "duration-list" -> config.getDurationList(path).stream().map(d -> Long.toString(d.toNanos())).toList();
      case "bytes-list" -> config.getBytesList(path).stream().map(Object::toString).toList();
      case "memory-list" -> config.getMemorySizeList(path).stream().map(d -> d.toBytesBigInteger().toString()).toList();
      case "config" -> config.getConfig(path).root().unwrapped();
      case "config-list" -> config.getConfigList(path).stream().map(c -> c.root().unwrapped()).toList();
      case "list" -> config.getAnyRefList(path);
      case "has" -> config.hasPath(path);
      case "null" -> config.getIsNull(path);
      default -> throw new IllegalArgumentException("unknown getter");
    };
  }
  static Map<String,Object> handle(Config req){
    var options=ConfigParseOptions.defaults().setAllowMissing(false);
    if(req.hasPath("classpath")) {
      try{var urls=new ArrayList<URL>();for(String s:req.getStringList("classpath"))urls.add(new File(s).toURI().toURL());options=options.setClassLoader(new URLClassLoader(urls.toArray(new URL[0]),null));}
      catch(java.net.MalformedURLException e){throw new IllegalArgumentException(e);}
    }
    if(req.hasPath("includes"))options=options.setIncluder(new MemoryIncludes(strings(req,"includes")));
    Config config=req.hasPath("url")?fromURL(req.getString("url"),options):req.hasPath("file")?ConfigFactory.parseFile(new File(req.getString("file")),options):ConfigFactory.parseString(req.hasPath("source")?req.getString("source"):"",options);
    if(req.hasPath("fallbacks"))for(String s:req.getStringList("fallbacks"))config=config.withFallback(ConfigFactory.parseString(s,options));
    if(req.hasPath("fallbackFiles"))for(String s:req.getStringList("fallbackFiles"))config=config.withFallback(ConfigFactory.parseFile(new File(s),options));
    if(req.hasPath("fallbackURLs"))for(String s:req.getStringList("fallbackURLs"))config=config.withFallback(fromURL(s,options));
    var resolve=ConfigResolveOptions.noSystem();
    if(req.hasPath("systemEnvironment")&&req.getBoolean("systemEnvironment"))resolve=resolve.setUseSystemEnvironment(true);
    if(req.hasPath("environment"))resolve=resolve.appendResolver(new Environment(strings(req,"environment"),null));
    config=config.resolve(resolve);
    Object result=req.hasPath("getter")?getter(config,req):config.root().unwrapped();
    Map<String,Object> out=new LinkedHashMap<>();out.put("accepted",true);out.put("value",result);return out;
  }
  public static void main(String[] args)throws Exception{
    var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8),true);
    try(var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8))){
      for(String line;(line=input.readLine())!=null;){
        if(args.length==1&&args[0].equals("--benchmark")){
          String result="";double[] samples=new double[15];
          for(int i=-10;i<samples.length;i++){
            long start=System.nanoTime();
            for(int repeat=0;repeat<3;repeat++)result=ConfigValueFactory.fromMap(handle(ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON)))).render(RENDER);
            if(i>=0)samples[i]=(System.nanoTime()-start)/3000000.0;
          }
          var record=new LinkedHashMap<String,Object>();record.put("samplesMs",Arrays.stream(samples).boxed().toList());record.put("result",result);record.put("java",System.getProperty("java.version"));
          output.println(ConfigValueFactory.fromMap(record).render(RENDER));continue;
        }
        Map<String,Object> result;
        try{result=handle(ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON)));}
        catch(ConfigException|IllegalArgumentException|ArithmeticException e){result=new LinkedHashMap<>();result.put("accepted",false);result.put("error",e.getClass().getSimpleName());}
        output.println(ConfigValueFactory.fromMap(result).render(RENDER));
      }
    }
  }
}
