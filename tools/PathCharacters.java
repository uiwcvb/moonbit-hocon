// Independent data adapter for the JDK character classification used in path rendering.
import java.util.*;
public class PathCharacters {
  public static void main(String[] args) {
    var ranges=new ArrayList<String>();
    for(int cp=0;cp<=65535;cp++)if(Character.isLetterOrDigit((char)cp)){
      int start=cp;
      while(cp<65535&&Character.isLetterOrDigit((char)(cp+1)))cp++;
      ranges.add("["+start+","+cp+"]");
    }
    System.out.println("{\"java\":\""+System.getProperty("java.version")+"\",\"ranges\":["+String.join(",",ranges)+"]}");
  }
}
