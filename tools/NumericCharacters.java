// Original JDK data adapter for radix-10 integer parsing of UTF-16 chars.
import java.util.*;
public class NumericCharacters {
  public static void main(String[] args) {
    var starts=new ArrayList<String>();
    for(int cp=0;cp<=65535;cp++)if(Character.digit((char)cp,10)>=0){
      if(Character.digit((char)cp,10)!=0)throw new AssertionError(cp);
      for(int i=0;i<10;i++)if(Character.digit((char)(cp+i),10)!=i)throw new AssertionError(cp+i);
      starts.add(Integer.toString(cp));cp+=9;
    }
    System.out.println("{\"java\":\""+System.getProperty("java.version")+"\",\"starts\":["+String.join(",",starts)+"]}");
  }
}
