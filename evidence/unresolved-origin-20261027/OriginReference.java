import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

// JSON-lines observation adapter. All parsing/resolution/error facts come from
// the unchanged Config 1.4.9 JAR; no expected values or synthetic exceptions.
class OriginReference {
  static class Includes implements ConfigIncluder {
    final Map<String,String> sources;
    Includes(Map<String,String> sources) { this.sources=sources; }
    public ConfigIncluder withFallback(ConfigIncluder fallback) { return this; }
    public ConfigObject include(ConfigIncludeContext context,String name) {
      String text=sources.get(name);
      if(text==null) return ConfigFactory.empty().root();
      return ConfigFactory.parseString(text,context.parseOptions()
          .setIncluder(this).setOriginDescription(name)).root();
    }
  }
  static Config parse(String name,String text,Map<String,String> includes) {
    return ConfigFactory.parseString(text,ConfigParseOptions.defaults()
        .setOriginDescription(name).setIncluder(new Includes(includes)));
  }
  public static void main(String[] args) throws Exception {
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8),true);
    for(String line;(line=input.readLine())!=null;) {
      var req=ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON));
      var result=new LinkedHashMap<String,Object>();
      result.put("id",req.getString("id"));
      try {
        var includes=new LinkedHashMap<String,String>();
        if(req.hasPath("includes"))for(var e:req.getObject("includes").entrySet())
          includes.put(e.getKey(),(String)e.getValue().unwrapped());
        Config value=parse(req.getString("name"),req.getString("source"),includes);
        if(req.hasPath("fallbacks"))for(Config fallback:req.getConfigList("fallbacks"))
          value=value.withFallback(parse(fallback.getString("name"),fallback.getString("source"),includes));
        value=value.resolve(ConfigResolveOptions.noSystem());
        result.put("accepted",true);result.put("value",value.root().unwrapped());
      } catch(ConfigException error) {
        result.put("accepted",false);result.put("errorClass",error.getClass().getName());
        result.put("message",error.getMessage());
        if(error.origin()!=null) {
          result.put("originDescription",error.origin().description());
          result.put("line",error.origin().lineNumber());
          result.put("filename",error.origin().filename());
        }
      }
      output.println(ConfigValueFactory.fromMap(result).render(ConfigRenderOptions.concise()));
    }
  }
}
