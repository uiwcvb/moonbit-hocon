import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

// Independent JDK Integer parsing, used only on the bounded ASCII fast-path domain.
class SmallIntegerOracle {
 public static void main(String[] args)throws Exception{
  var input=new BufferedReader(new InputStreamReader(System.in,StandardCharsets.UTF_8));
  for(String line;(line=input.readLine())!=null;){String text=new String(Base64.getDecoder().decode(line),StandardCharsets.UTF_8);try{System.out.println(Integer.valueOf(text));}catch(NumberFormatException e){System.out.println("null");}}
 }
}
