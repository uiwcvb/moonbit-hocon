import com.typesafe.config.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

// Original test adapter. The upstream jar is supplied separately, outside this repository.
class HoconReference {
  public static void main(String[] args) throws Exception {
    try (var input = new BufferedReader(new InputStreamReader(System.in, StandardCharsets.UTF_8))) {
      for (String line; (line = input.readLine()) != null;) {
        String result;
        String status;
        try {
          String source = new String(Base64.getDecoder().decode(line), StandardCharsets.UTF_8);
          var config = ConfigFactory.parseString(source).resolve(ConfigResolveOptions.noSystem());
          result = config.root().render(ConfigRenderOptions.concise());
          status = "OK:";
        } catch (ConfigException e) { status = "ERR:"; result = e.getClass().getSimpleName(); }
        System.out.println(status + Base64.getEncoder().encodeToString(result.getBytes(StandardCharsets.UTF_8)));
      }
    }
  }
}
