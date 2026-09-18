import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.function.Supplier;

// Original JSON-lines adapter. Expectations are produced by the unmodified JAR.
class ValueOracle {
  static final ConfigRenderOptions JSON=ConfigRenderOptions.concise();
  static Map<String,Object> ok(Object value){var out=new LinkedHashMap<String,Object>();out.put("accepted",true);out.put("value",value);return out;}
  static Map<String,Object> attempt(Supplier<Object> work){try{return ok(work.get());}catch(RuntimeException error){return Map.of("accepted",false);}}
  static Object snapshot(ConfigValue value){return Map.of("type",attempt(()->value.valueType().name()),"unwrapped",attempt(value::unwrapped));}
  static ConfigValue create(String text,boolean resolved){
    Config config=ConfigFactory.parseString("v="+text);if(resolved)config=config.resolve(ConfigResolveOptions.noSystem());
    ConfigValue value=config.root().get("v");if(value==null)throw new IllegalArgumentException("value disappeared");return value;
  }
  static Object run(Config req){
    Config config=ConfigFactory.parseString(req.getString("source"));
    if(req.hasPath("resolved")&&req.getBoolean("resolved"))config=config.resolve(ConfigResolveOptions.noSystem());
    var values=new ArrayList<ConfigValue>();values.add(config.root());
    var results=new ArrayList<Object>();
    for(Config step:req.getConfigList("calls"))results.add(attempt(()->{
      String op=step.getString("op");ConfigValue value=values.get(step.hasPath("target")?step.getInt("target"):0);
      ConfigValue other=step.hasPath("other")?values.get(step.getInt("other")):value;
      String key=step.hasPath("key")?step.getString("key"):"";
      switch(op){
        case "type":return value.valueType().name();
        case "unwrap":return value.unwrapped();
        case "size":return value instanceof ConfigObject o?o.size():((ConfigList)value).size();
        case "empty":return value instanceof ConfigObject o?o.isEmpty():((ConfigList)value).isEmpty();
        case "keys":return ((ConfigObject)value).keySet().stream().sorted().toList();
        case "contains-key":return ((ConfigObject)value).containsKey(key);
        case "contains-value":return value instanceof ConfigObject o?o.containsValue(other):((ConfigList)value).contains(other);
        case "equals":return value.equals(other);
        case "hash":return value.hashCode();
        case "index-of":return ((ConfigList)value).indexOf(other);
        case "last-index-of":return ((ConfigList)value).lastIndexOf(other);
        case "values":return (value instanceof ConfigObject o?o.values():((ConfigList)value)).stream().map(ValueOracle::snapshot).toList();
        case "sub-list":return ((ConfigList)value).subList(step.getInt("from"),step.getInt("to")).stream().map(ValueOracle::snapshot).toList();
        case "mutate":if(value instanceof ConfigObject o)o.clear();else ((ConfigList)value).clear();return null;
      }
      ConfigValue next=switch(op){
        case "new" -> create(step.getString("source"),step.hasPath("resolved")&&step.getBoolean("resolved"));
        case "get-key" -> ((ConfigObject)value).get(key);
        case "get-index" -> ((ConfigList)value).get(step.getInt("index"));
        case "get-value" -> ((ConfigObject)value).toConfig().getValue(key);
        case "get-object" -> ((ConfigObject)value).toConfig().getObject(key);
        case "get-list" -> ((ConfigObject)value).toConfig().getList(key);
        case "with-value" -> ((ConfigObject)value).withValue(key,other);
        case "only-key" -> ((ConfigObject)value).withOnlyKey(key);
        case "without-key" -> ((ConfigObject)value).withoutKey(key);
        case "fallback" -> value.withFallback(step.hasPath("asConfig")&&step.getBoolean("asConfig")?((ConfigObject)other).toConfig():other);
        case "config-fallback" -> ((ConfigObject)value).toConfig().withFallback(step.hasPath("asConfig")&&step.getBoolean("asConfig")?((ConfigObject)other).toConfig():other).root();
        case "at-key" -> value.atKey(key).root();
        case "at-path" -> value.atPath(key).root();
        case "to-config" -> ((ConfigObject)value).toConfig().root();
        case "resolve" -> ((ConfigObject)value).toConfig().resolve(ConfigResolveOptions.noSystem().setAllowUnresolved(step.hasPath("allowUnresolved")&&step.getBoolean("allowUnresolved"))).root();
        default -> throw new IllegalArgumentException("unknown operation: "+op);
      };
      if(next==null)return null;int id=values.size();values.add(next);return id;
    }));
    return ok(Map.of("results",results,"final",values.stream().map(ValueOracle::snapshot).toList()));
  }
  public static void main(String[] args)throws Exception{
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var out=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));
    for(String line;(line=input.readLine())!=null;){
      Object result;
      try{Config request=ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON));result=args.length>0&&args[0].equals("--benchmark")?benchmark(request):run(request);}
      catch(RuntimeException error){result=Map.of("accepted",false);}
      out.println(ConfigValueFactory.fromAnyRef(result).render(JSON));
    }
    out.flush();
  }
  static Object benchmark(Config request){
    Config config=ConfigFactory.parseString(request.getString("source")).resolve(ConfigResolveOptions.noSystem());
    ConfigValue child=config.getValue("child"),other=ConfigFactory.parseString(request.getString("source")).resolve(ConfigResolveOptions.noSystem()).getValue("child"),needle=ConfigValueFactory.fromAnyRef(1);
    ConfigList list=config.getList("list");ConfigValue fallback=create("{additional=2}",true);
    int repeats=request.getInt("repeats");String mode=request.getString("mode");
    Supplier<Object> work=()->{var result=new ArrayList<Object>();for(int j=0;j<repeats;j++)result.add(switch(mode){
      case "value-read" -> config.getValue("child").unwrapped();
      case "value-hash" -> child.hashCode();
      case "value-cold-hash" -> config.getValue("child").hashCode();
      case "value-equals" -> child.equals(other);
      case "value-search" -> list.indexOf(needle);
      case "value-fallback" -> child.withFallback(fallback).unwrapped();
      default -> throw new IllegalArgumentException(mode);
    });return result;};
    Object result=null;var samples=new ArrayList<Double>();
    for(int i=-10;i<15;i++){long start=System.nanoTime();for(int j=0;j<3;j++)result=work.get();if(i>=0)samples.add((System.nanoTime()-start)/3e6);}
    return Map.of("name",request.getString("name"),"samplesMs",samples,"result",ConfigValueFactory.fromAnyRef(result).render(JSON),"java",System.getProperty("java.version"));
  }
}
