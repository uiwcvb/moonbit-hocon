import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

// Original retained-list benchmark. Exact result bits are serialized after timing.
class DoubleReadOracle {
  static Object benchmark(Config request){
    Config config=ConfigFactory.parseString(request.getString("source")).resolve(ConfigResolveOptions.noSystem());
    int repeats=request.getInt("repeats");
    List<List<Double>> result=null;var samples=new ArrayList<Double>();
    for(int sample=-10;sample<15;sample++){
      long start=System.nanoTime();
      for(int n=0;n<3;n++){result=new ArrayList<>();for(int r=0;r<repeats;r++)result.add(config.getDoubleList("values"));}
      if(sample>=0)samples.add((System.nanoTime()-start)/3e6);
    }
    var bits=new ArrayList<List<String>>();
    for(var values:result){var row=new ArrayList<String>();for(double value:values)row.add(Long.toString(Double.doubleToLongBits(value)));bits.add(row);}
    return Map.of("name",request.getString("name"),"samplesMs",samples,"result",ConfigValueFactory.fromAnyRef(bits).render(ConfigRenderOptions.concise()),"java",System.getProperty("java.version"));
  }
  public static void main(String[] args)throws Exception{
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var out=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));
    for(String line;(line=input.readLine())!=null;)out.println(ConfigValueFactory.fromAnyRef(benchmark(ConfigFactory.parseString(line,ConfigParseOptions.defaults().setSyntax(ConfigSyntax.JSON)))).render(ConfigRenderOptions.concise()));
    out.flush();
  }
}
