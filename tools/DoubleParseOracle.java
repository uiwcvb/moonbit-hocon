import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

// Original adapter to JDK binary64 parsing; Base64 carries control characters.
class DoubleParseOracle {
  public static void main(String[] args)throws Exception{
    var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
    var output=new PrintWriter(new OutputStreamWriter(System.out,StandardCharsets.UTF_8));
    for(String line;(line=input.readLine())!=null;){
      var text=new String(Base64.getDecoder().decode(line),StandardCharsets.UTF_8);
      try{output.println(Long.toString(Double.doubleToLongBits(Double.parseDouble(text))));}
      catch(NumberFormatException error){output.println("ERROR");}
    }
    output.flush();
  }
}
