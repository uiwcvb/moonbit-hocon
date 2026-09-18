import java.io.*;
import java.nio.charset.StandardCharsets;

// Original adapter to the pinned JDK's public binary64 formatting operation.
class DoubleRenderOracle {
  public static void main(String[] args)throws Exception{
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));
    for(String line;(line=input.readLine())!=null;)output.println(Double.toString(Double.longBitsToDouble(Long.parseLong(line))));
    output.flush();
  }
}
