import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.function.Supplier;

// Original adapter; all expected behavior comes from the unmodified pinned JAR.
class EntryOracle {
 static final ConfigRenderOptions JSON=ConfigRenderOptions.concise();
 static Map<String,Object> ok(Object value){var out=new LinkedHashMap<String,Object>();out.put("accepted",true);out.put("value",value);return out;}
 static Object attempt(Supplier<Object> work){try{return ok(work.get());}catch(RuntimeException e){return Map.of("accepted",false);}}
 static Object valueSnapshot(ConfigValue value){if(value==null)return null;return Map.of("type",attempt(()->value.valueType().name()),"unwrap",attempt(value::unwrapped),"render",attempt(()->value.render(JSON)),"hash",attempt(value::hashCode));}
 static Object entrySnapshot(Map.Entry<String,ConfigValue> entry){if(entry==null)return null;var out=new LinkedHashMap<String,Object>();out.put("key",entry.getKey());out.put("value",valueSnapshot(entry.getValue()));return out;}
 static int compareEntries(Map.Entry<String,ConfigValue> a,Map.Entry<String,ConfigValue> b){if(a==null)return b==null?0:-1;if(b==null)return 1;int keys=Comparator.nullsFirst(Comparator.<String>naturalOrder()).compare(a.getKey(),b.getKey());if(keys!=0)return keys;return (a.getValue()==null?"":a.getValue().render(JSON)).compareTo(b.getValue()==null?"":b.getValue().render(JSON));}
 static Object setSnapshot(Set<Map.Entry<String,ConfigValue>> set){return Map.of("size",set.size(),"empty",set.isEmpty(),"hash",attempt(set::hashCode),"entries",set.stream().sorted(EntryOracle::compareEntries).map(EntryOracle::entrySnapshot).toList());}
 static ConfigValue value(String source){return ConfigFactory.parseString("v="+source).root().get("v");}
 static Map.Entry<String,ConfigValue> makeEntry(ConfigValue spec){if(spec.valueType()==ConfigValueType.NULL)return null;Config c=((ConfigObject)spec).toConfig();return new AbstractMap.SimpleImmutableEntry<>(c.getIsNull("key")?null:c.getString("key"),c.getIsNull("value")?null:value(c.getString("value")));}
 static int index(Config call,String key){return call.hasPath(key)?call.getInt(key):0;}
 static Config parse(String source,Config req){var options=ConfigParseOptions.defaults();if(req.hasPath("includes")){var includes=req.getConfig("includes");options=options.setIncluder(new ConfigIncluder(){public ConfigIncluder withFallback(ConfigIncluder other){return this;}public ConfigObject include(ConfigIncludeContext context,String what){return ConfigFactory.parseString(includes.getString(ConfigUtil.joinPath(what))).root();}});}return ConfigFactory.parseString(source,options);}
 static Object run(Config req){
  Config initial=parse(req.getString("source"),req);if(req.hasPath("resolved")&&req.getBoolean("resolved"))initial=initial.resolve(ConfigResolveOptions.noSystem());
  var configs=new ArrayList<Config>();configs.add(initial);var sets=new ArrayList<Set<Map.Entry<String,ConfigValue>>>();var entries=new ArrayList<Map.Entry<String,ConfigValue>>();var iterators=new ArrayList<Iterator<Map.Entry<String,ConfigValue>>>();var results=new ArrayList<Object>();
  for(Config c:req.getConfigList("calls"))results.add(attempt(()->{
   String op=c.getString("op");int s=index(c,"set"),e=index(c,"entry"),it=index(c,"iterator"),ci=index(c,"config");
   switch(op){
    case "enumerate":{var set=configs.get(ci).entrySet();int id=sets.size();sets.add(set);return id;}
    case "new-set":{var set=new HashSet<Map.Entry<String,ConfigValue>>();for(ConfigValue v:c.getList("entries"))set.add(makeEntry(v));int id=sets.size();sets.add(set);return id;}
    case "copy-set":{var set=new HashSet<>(sets.get(s));int id=sets.size();sets.add(set);return id;}
    case "new-entry":{int id=entries.size();entries.add(makeEntry(c.root().get("spec")));return id;}
    case "find-entry":{var entry=sets.get(s).stream().filter(v->v!=null&&Objects.equals(v.getKey(),c.getString("key"))).findFirst().orElseThrow();int id=entries.size();entries.add(entry);return id;}
    case "snapshot":return setSnapshot(sets.get(s));
    case "entry-snapshot":return entrySnapshot(entries.get(e));
    case "add":return sets.get(s).add(entries.get(e));
    case "remove":return sets.get(s).remove(entries.get(e));
    case "contains":return sets.get(s).contains(entries.get(e));
    case "clear":sets.get(s).clear();return null;
    case "add-all":return sets.get(s).addAll(sets.get(c.getInt("other")));
    case "remove-all":return sets.get(s).removeAll(sets.get(c.getInt("other")));
    case "retain-all":return sets.get(s).retainAll(sets.get(c.getInt("other")));
    case "contains-all":return sets.get(s).containsAll(sets.get(c.getInt("other")));
    case "equals":return sets.get(s).equals(sets.get(c.getInt("other")));
    case "entry-equals":return entries.get(e).equals(entries.get(c.getInt("other")));
    case "entry-set-value":return entries.get(e).setValue(value("9"));
    case "iterator":{int id=iterators.size();iterators.add(sets.get(s).iterator());return id;}
    case "has-next":return iterators.get(it).hasNext();
    case "next":iterators.get(it).next();return true;
    case "iterator-remove":iterators.get(it).remove();return null;
    case "value-at-key":return entries.get(e).getValue().atKey("copy").resolve(ConfigResolveOptions.noSystem().setAllowUnresolved(true)).root().render(JSON);
    case "value-list-get":return valueSnapshot(((ConfigList)entries.get(e).getValue()).get(c.getInt("index")));
    case "value-mutate":((ConfigList)entries.get(e).getValue()).clear();return null;
    case "config-resolve":{Config next=configs.get(ci).resolve(ConfigResolveOptions.noSystem().setAllowUnresolved(c.hasPath("allowUnresolved")&&c.getBoolean("allowUnresolved")));int id=configs.size();configs.add(next);return id;}
    case "config-fallback":{Config next=configs.get(ci).withFallback(ConfigFactory.parseString(c.getString("source")));int id=configs.size();configs.add(next);return id;}
    case "config-at-path":{Config next=configs.get(ci).atPath(c.getString("path"));int id=configs.size();configs.add(next);return id;}
    default:throw new IllegalArgumentException(op);
   }
  }));
  return Map.of("results",results,"sets",sets.stream().map(EntryOracle::setSnapshot).toList(),"configs",configs.stream().map(c->attempt(()->c.root().render(JSON))).toList());
 }
 public static void main(String[] args)throws Exception{var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));for(String line;(line=input.readLine())!=null;){final String text=line;output.println(ConfigValueFactory.fromAnyRef(attempt(()->run(ConfigFactory.parseString(text,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON))))).render(JSON));}output.flush();}
}
