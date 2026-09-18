import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

// Independently authored adapter; all path expectations come from the pinned JAR.
class PathOracle {
  public static void main(String[] args) throws Exception {
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));
    for(String line;(line=input.readLine())!=null;){
      String path=ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON)).getString("path");
      Object result;
      try{result=Map.of("accepted",true,"value",ConfigUtil.splitPath(path));}
      catch(ConfigException|IllegalArgumentException error){result=Map.of("accepted",false);}
      output.println(ConfigValueFactory.fromAnyRef(result).render(ConfigRenderOptions.concise()));
    }
    output.flush();
  }
}
