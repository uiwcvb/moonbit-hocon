import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

// Original adapter; every expected string comes from the unmodified reference JAR.
class RenderOracle {
  static class Includes implements ConfigIncluder {
    final Config files;
    Includes(Config files){this.files=files;}
    public ConfigIncluder withFallback(ConfigIncluder fallback){return this;}
    public ConfigObject include(ConfigIncludeContext context,String name){
      ConfigValue found=files.root().get(name);
      if(found==null){if(!context.parseOptions().getAllowMissing())throw new ConfigException.Generic("missing include");return ConfigFactory.empty().root();}
      return ConfigFactory.parseString((String)found.unwrapped(),context.parseOptions().setIncluder(this)).root();
    }
  }
  static boolean flag(Config req,String name,boolean fallback){return req.hasPath(name)?req.getBoolean(name):fallback;}
  static Config parse(String source){return ConfigFactory.parseString(source);}
  static ConfigValue value(String source){return parse("v="+source).root().get("v");}
  static ConfigValue prepare(Config req){
    ConfigParseOptions parsing=ConfigParseOptions.defaults();
    if(req.hasPath("includes"))parsing=parsing.setIncluder(new Includes(req.getConfig("includes")));
    ConfigValue current=req.hasPath("value")?value(req.getString("value")):ConfigFactory.parseString(req.getString("source"),parsing).root();
    if(flag(req,"resolved",false))current=((ConfigObject)current).toConfig().resolve(ConfigResolveOptions.noSystem()).root();
    if(req.hasPath("steps"))for(Config step:req.getConfigList("steps")){
      current=switch(step.getString("op")){
        case "key" -> ((ConfigObject)current).get(step.getString("key"));
        case "index" -> ((ConfigList)current).get(step.getInt("index"));
        case "path" -> ((ConfigObject)current).toConfig().getValue(step.getString("key"));
        case "fallback" -> current.withFallback(value(step.getString("value")));
        case "with-key" -> ((ConfigObject)current).withValue(step.getString("key"),value(step.getString("value")));
        case "without-key" -> ((ConfigObject)current).withoutKey(step.getString("key"));
        case "at-key" -> current.atKey(step.getString("key")).root();
        case "at-path" -> current.atPath(step.getString("key")).root();
        case "resolve" -> ((ConfigObject)current).toConfig().resolve(ConfigResolveOptions.noSystem().setAllowUnresolved(flag(step,"allowUnresolved",false))).root();
        default -> throw new IllegalArgumentException("unknown render operation");
      };
    }
    return current;
  }
  static ConfigRenderOptions options(Config req){return ConfigRenderOptions.concise().setJson(flag(req,"json",true)).setFormatted(flag(req,"formatted",false));}
  static Object run(Config req){return Map.of("accepted",true,"value",prepare(req).render(options(req)));}
  static Object benchmark(Config req){
    ConfigValue value=prepare(req);ConfigRenderOptions options=options(req);int repeats=req.getInt("repeats");
    List<String> result=null;var samples=new ArrayList<Double>();
    for(int sample=-10;sample<15;sample++){long start=System.nanoTime();for(int n=0;n<3;n++){result=new ArrayList<>();for(int r=0;r<repeats;r++)result.add(value.render(options));}if(sample>=0)samples.add((System.nanoTime()-start)/3e6);}
    return Map.of("name",req.getString("name"),"samplesMs",samples,"result",ConfigValueFactory.fromAnyRef(result).render(ConfigRenderOptions.concise()),"java",System.getProperty("java.version"));
  }
  public static void main(String[] args)throws Exception{
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var out=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));
    for(String line;(line=input.readLine())!=null;){Object result;try{Config req=ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON));result=args.length>0&&args[0].equals("--benchmark")?benchmark(req):run(req);}catch(RuntimeException e){result=Map.of("accepted",false);}
      out.println(ConfigValueFactory.fromAnyRef(result).render(ConfigRenderOptions.concise()));
    }out.flush();
  }
}
