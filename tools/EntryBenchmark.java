import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.function.IntSupplier;

class EntryBenchmark {
 public static void main(String[] args)throws Exception{
  var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
  for(String line;(line=input.readLine())!=null;){
   Config req=ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON));
   Config raw=ConfigFactory.parseString(req.getString("source"));final Config config=req.getBoolean("resolved")?raw.resolve(ConfigResolveOptions.noSystem()):raw;
   int repeats=req.getInt("repeats");boolean hash=req.getString("mode").equals("hash");
   IntSupplier work=()->{int sum=0;for(int n=0;n<repeats;n++){var entries=config.entrySet();sum+=hash?entries.hashCode():entries.size();}return sum;};
   var samples=new ArrayList<Double>();int result=0;
   for(int i=-10;i<15;i++){long start=System.nanoTime();for(int n=0;n<3;n++)result=work.getAsInt();if(i>=0)samples.add((System.nanoTime()-start)/3e6);}
   System.out.println(ConfigValueFactory.fromAnyRef(Map.of("name",req.getString("name"),"samplesMs",samples,"result",result,"java",System.getProperty("java.version"))).render(ConfigRenderOptions.concise()));
  }
 }
}
