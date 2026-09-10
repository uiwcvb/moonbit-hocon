///|
fn run(input : String) -> String {
  Repr(@lib.parse(input)).to_string() catch {
    e => "ERROR: " + Repr(e).to_string()
  }
}

///|
fn main {
  println(
    run(
      "service { host = \"localhost\", port = 8080 }\nservice.port = 9090\nendpoint = ${service.host}",
    ),
  )
}
