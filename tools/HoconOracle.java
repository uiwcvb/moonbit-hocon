import com.typesafe.config.*;
import java.io.*;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.charset.StandardCharsets;
import java.util.*;

// Original JSON-lines adapter around the unmodified upstream library.
class HoconOracle {
  enum Choice { RED,GREEN,BLUE,on,yes,NaN,Infinity,蓝色,Α,_foo,$dollar }
  static Object period(java.time.Period p){return Map.of("years",p.getYears(),"months",p.getMonths(),"days",p.getDays());}
  static Object temporal(java.time.temporal.TemporalAmount t){
    if(t instanceof java.time.Duration d)return Map.of("kind","duration","nanoseconds",Long.toString(d.toNanos()));
    var p=(java.time.Period)t;return Map.of("kind","period","years",p.getYears(),"months",p.getMonths(),"days",p.getDays());
  }
  static Object numeric(Number n){
    if(n instanceof Integer)return Map.of("kind","int","value",n.toString());
    if(n instanceof Long)return Map.of("kind","long","value",n.toString());
    double d=n.doubleValue();return Map.of("kind","double","value",Double.isFinite(d)&&!(d==0.0&&Double.doubleToRawLongBits(d)<0)?(Object)d:Double.toString(d),"bits",Long.toString(Double.doubleToLongBits(d)));
  }
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
    String kind=req.getString("getter"),path=req.hasPath("path")?req.getString("path"):"";
    return switch(kind){
      case "string" -> config.getString(path);
      case "boolean" -> config.getBoolean(path);
      case "int" -> config.getInt(path);
      case "long" -> Long.toString(config.getLong(path));
      case "double" -> {double d=config.getDouble(path);yield Double.isFinite(d)?d:Double.toString(d);}
      case "number" -> numeric(config.getNumber(path));
      case "number-list" -> config.getNumberList(path).stream().map(HoconOracle::numeric).toList();
      case "object" -> config.getObject(path).unwrapped();
      case "object-list" -> config.getObjectList(path).stream().map(ConfigObject::unwrapped).toList();
      case "any-ref" -> config.getAnyRef(path);
      case "any-ref-list" -> config.getAnyRefList(path);
      case "enum" -> config.getEnum(Choice.class,path).name();
      case "enum-list" -> config.getEnumList(Choice.class,path).stream().map(Enum::name).toList();
      case "period" -> period(config.getPeriod(path));
      case "temporal" -> temporal(config.getTemporal(path));
      case "duration-in" -> Long.toString(config.getDuration(path,java.util.concurrent.TimeUnit.valueOf(req.getString("unit").toUpperCase(Locale.ROOT))));
      case "duration-list-in" -> config.getDurationList(path,java.util.concurrent.TimeUnit.valueOf(req.getString("unit").toUpperCase(Locale.ROOT))).stream().map(Object::toString).toList();
      case "milliseconds" -> Long.toString(config.getMilliseconds(path));
      case "nanoseconds" -> Long.toString(config.getNanoseconds(path));
      case "milliseconds-list" -> config.getMillisecondsList(path).stream().map(Object::toString).toList();
      case "nanoseconds-list" -> config.getNanosecondsList(path).stream().map(Object::toString).toList();
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
      case "has-or-null" -> config.hasPathOrNull(path);
      case "empty" -> config.isEmpty();
      case "resolved" -> config.isResolved();
      case "entries" -> {var entries=new TreeMap<String,Object>();for(var e:config.entrySet())entries.put(e.getKey(),e.getValue().unwrapped());yield entries;}
      case "validation" -> validation(config,ConfigFactory.parseString(req.getString("referenceSource")).resolve(ConfigResolveOptions.noSystem()),req.hasPath("validationPaths")?req.getStringList("validationPaths"):List.of());
      default -> throw new IllegalArgumentException("unknown getter");
    };
  }
  static Map<String,Object> handle(Config req){
    var options=ConfigParseOptions.defaults().setAllowMissing(false);
    if(req.hasPath("format"))options=options.setSyntax(req.getString("format").equals("json")?ConfigSyntax.JSON:ConfigSyntax.CONF);
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
    if(req.hasPath("persistent")&&req.getBoolean("persistent"))return persistent(config,req,options,resolve);
    if(req.hasPath("document")&&req.getBoolean("document")){
      var states=new ArrayList<Object>();states.add(documentState(config,req));
      if(req.hasPath("steps"))for(Config step:req.getConfigList("steps")){
        String op=step.getString("op");
        var selected=resolve.setAllowUnresolved(step.hasPath("allowUnresolved")&&step.getBoolean("allowUnresolved"));
        if(op.equals("resolve"))config=config.resolve(selected);
        else if(op.equals("resolve-with-self"))config=config.resolveWith(config,selected);
        else if(op.equals("resolve-with"))config=config.resolveWith(ConfigFactory.parseString(step.getString("source"),options),selected);
        else if(op.equals("with-fallback"))config=config.withFallback(ConfigFactory.parseString(step.getString("source"),options));
        else if(op.equals("with-value")||op.equals("with-key-value")){
          ConfigValue value=step.hasPath("valueSource")?ConfigFactory.parseString("value="+step.getString("valueSource"),options).root().get("value"):step.root().get("value");
          config=op.equals("with-value")?config.withValue(step.getString("path"),value):config.root().withValue(step.getString("path"),value).toConfig();
        }else config=operation(config,step);
        states.add(documentState(config,req));
      }
      return Map.of("accepted",true,"value",states);
    }
    config=config.resolve(resolve);
    if(req.hasPath("operations"))for(Config op:req.getConfigList("operations"))config=operation(config,op);
    if(req.hasPath("checkValid")){Config check=req.getConfig("checkValid");config.checkValid(ConfigFactory.parseString(check.getString("source")).resolve(ConfigResolveOptions.noSystem()),(check.hasPath("paths")?check.getStringList("paths"):List.<String>of()).toArray(new String[0]));}
    Object result=req.hasPath("getter")?getter(config,req):config.root().unwrapped();
    Map<String,Object> out=new LinkedHashMap<>();out.put("accepted",true);out.put("value",result);return out;
  }
  static Map<String,Object> persistent(Config initial,Config req,ConfigParseOptions options,ConfigResolveOptions resolve){
    if(req.hasPath("resolved")&&req.getBoolean("resolved"))initial=initial.resolve(resolve);
    var configs=new ArrayList<Config>();configs.add(initial);
    var results=new ArrayList<Object>();var first=documentState(initial,req);
    for(Config step:req.getConfigList("calls")){
      try{
        Config config=configs.get(step.hasPath("target")?step.getInt("target"):0);
        String action=step.getString("action");Object value;
        if(action.equals("read"))value=getter(config,step);
        else if(action.equals("validate")){
          Config reference=configs.get(step.getInt("other"));var paths=step.hasPath("paths")?step.getStringList("paths"):List.<String>of();
          if(step.hasPath("problems")&&step.getBoolean("problems"))value=validation(config,reference,paths);
          else {config.checkValid(reference,paths.toArray(new String[0]));value=null;}
        } else if(action.equals("children")){
          var ids=new ArrayList<Integer>();for(Config child:config.getConfigList(step.getString("path"))){ids.add(configs.size());configs.add(child);}value=ids;
        } else {
          Config next;
          if(action.equals("create")){
            next=ConfigFactory.parseString(step.getString("source"),options);
            if(step.hasPath("resolved")&&step.getBoolean("resolved"))next=next.resolve(resolve);
          }else{
            String op=step.getString("op");
            var selected=resolve.setAllowUnresolved(step.hasPath("allowUnresolved")&&step.getBoolean("allowUnresolved"));
            next=switch(op){
              case "resolve" -> config.resolve(selected);
              case "resolve-with" -> config.resolveWith(configs.get(step.getInt("other")),selected);
              case "with-fallback" -> config.withFallback(configs.get(step.getInt("other")));
              case "get-config" -> config.getConfig(step.getString("path"));
              case "with-value-source" -> config.withValue(step.getString("path"),ConfigFactory.parseString("value="+step.getString("source"),options).root().get("value"));
              case "with-value-from" -> config.withValue(step.getString("path"),configs.get(step.getInt("other")).getValue(step.getString("valuePath")));
              default -> operation(config,step);
            };
          }
          value=configs.size();configs.add(next);
        }
        var success=new LinkedHashMap<String,Object>();success.put("accepted",true);success.put("value",value);results.add(success);
      }catch(ConfigException|IllegalArgumentException|ArithmeticException|IndexOutOfBoundsException e){results.add(Map.of("accepted",false));}
    }
    return Map.of("accepted",true,"value",Map.of("initial",first,"results",results,"final",configs.stream().map(c->documentState(c,req)).toList()));
  }
  static Object documentState(Config config,Config req){
    var state=new LinkedHashMap<String,Object>();state.put("resolved",config.isResolved());
    if(config.isResolved())state.put("value",config.root().unwrapped());
    var probes=new LinkedHashMap<String,Object>();
    if(req.hasPath("probes"))for(String path:req.getStringList("probes")){
      try{probes.put(path,Map.of("accepted",true,"value",config.getValue(path).unwrapped()));}
      catch(ConfigException e){probes.put(path,Map.of("accepted",false));}
    }
    state.put("probes",probes);return state;
  }
  static List<Map<String,Object>> validationProblems(ConfigException.ValidationFailed failure){
    var problems=new ArrayList<Map<String,Object>>();
    for(var p:failure.problems()){
      String text=p.problem(),kind=text.startsWith("No setting")?"missing":text.startsWith("List at")?"list-element":"wrong-type";
      problems.add(Map.of("path",p.path(),"kind",kind));
    }
    return problems;
  }
  static Object validation(Config config,Config reference,List<String> paths){
    try{config.checkValid(reference,paths.toArray(new String[0]));return List.of();}
    catch(ConfigException.ValidationFailed failure){return validationProblems(failure);}
  }
  static Config operation(Config config,Config op){
    String kind=op.getString("op"),path=op.hasPath("path")?op.getString("path"):"";
    return switch(kind){
      case "without-path" -> config.withoutPath(path);
      case "with-only-path" -> config.withOnlyPath(path);
      case "at-path" -> config.atPath(path);
      case "at-key" -> config.atKey(path);
      case "without-key" -> config.root().withoutKey(path).toConfig();
      case "with-only-key" -> config.root().withOnlyKey(path).toConfig();
      case "with-value", "with-key-value" -> {
        ConfigValue value=op.hasPath("valueSource")?ConfigFactory.parseString("value="+op.getString("valueSource")).resolve(ConfigResolveOptions.noSystem()).root().get("value"):op.root().get("value");
        yield kind.equals("with-value")?config.withValue(path,value):config.root().withValue(path,value).toConfig();
      }
      case "with-fallback" -> config.withFallback(ConfigFactory.parseString(op.getString("source")).resolve(ConfigResolveOptions.noSystem()));
      default -> throw new IllegalArgumentException("unknown operation");
    };
  }
  static Object retainedBenchmark(Config req){
    String mode=req.getString("mode"),source=req.getString("source");
    Config initial=ConfigFactory.parseString(source);
    Config config=mode.equals("resolve")?initial:initial.resolve(ConfigResolveOptions.noSystem());
    List<String> paths=req.hasPath("paths")?req.getStringList("paths"):List.of();
    int repeats=req.getInt("repeats");
    java.util.function.Supplier<Object> work=()->{
      var values=new ArrayList<Object>();
      switch(mode){
        case "int":for(String path:paths)values.add(config.getInt(path));break;
        case "number":for(String path:paths)values.add(numeric(config.getNumber(path)));break;
        case "child":for(int i=0;i<repeats;i++)values.add(config.getConfig("child").getInt("port"));break;
        case "period":for(int i=0;i<repeats;i++)values.add(period(config.getPeriod("period")));break;
        case "edits":for(int i=0;i<repeats;i++)values.add(config.withValue("counter",ConfigValueFactory.fromAnyRef(i)).root().unwrapped());break;
        case "resolve":for(int i=0;i<repeats;i++)values.add(config.resolve(ConfigResolveOptions.noSystem()).root().unwrapped());break;
        default:throw new IllegalArgumentException("unknown retained benchmark");
      }
      return values;
    };
    Object result=null;double[] samples=new double[15];
    for(int i=-10;i<samples.length;i++){
      long start=System.nanoTime();for(int repeat=0;repeat<3;repeat++)result=work.get();
      if(i>=0)samples[i]=(System.nanoTime()-start)/3000000.0;
    }
    return Map.of("samplesMs",Arrays.stream(samples).boxed().toList(),"result",ConfigValueFactory.fromAnyRef(result).render(RENDER),"java",System.getProperty("java.version"));
  }
  public static void main(String[] args)throws Exception{
    var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8),true);
    try(var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8))){
      for(String line;(line=input.readLine())!=null;){
        if(args.length==1&&args[0].equals("--retained-benchmark")){
          output.println(ConfigValueFactory.fromAnyRef(retainedBenchmark(ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON)))).render(RENDER));continue;
        }
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
        catch(ConfigException|IllegalArgumentException|ArithmeticException e){result=new LinkedHashMap<>();result.put("accepted",false);result.put("error",e.getClass().getSimpleName());if(e instanceof ConfigException.ValidationFailed failure)result.put("problems",validationProblems(failure));}
        output.println(ConfigValueFactory.fromMap(result).render(RENDER));
      }
    }
  }
}
