import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

// Public Config getters, including String-to-Long-before-Double conversion.
class DoubleGetterOracle {
  static String bits(double value){return Long.toString(Double.doubleToLongBits(value));}
  public static void main(String[] args)throws Exception{
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));
    for(String line;(line=input.readLine())!=null;){
      String[] fields=line.split("\t",2);
      String value=new String(Base64.getDecoder().decode(fields[1]),StandardCharsets.UTF_8);
      String scalar="ERROR",list="ERROR";
      try{
        Config config=fields[0].equals("text")?ConfigFactory.empty().withValue("v",ConfigValueFactory.fromAnyRef(value)):ConfigFactory.parseString("v="+value).resolve(ConfigResolveOptions.noSystem());
        try{scalar=bits(config.getDouble("v"));}catch(ConfigException ignored){}
        try{list=bits(ConfigFactory.parseString("items=[${v}]").withFallback(config).resolve(ConfigResolveOptions.noSystem()).getDoubleList("items").get(0));}catch(ConfigException ignored){}
      }catch(ConfigException ignored){}
      output.println(scalar+"\t"+list);
    }
    output.flush();
  }
}
