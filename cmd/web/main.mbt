///|
pub fn run(input : String) -> String {
  Repr(@lib.parse(input)).to_string() catch {
    e => "ERROR: " + Repr(e).to_string()
  }
}

///|
fn main {

}

///|
pub fn json(source : String) -> String {
  @lib.parse(source).to_json_string() catch {
    e => "ERROR: " + Repr(e).to_string()
  }
}
