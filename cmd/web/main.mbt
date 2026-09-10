///|
pub fn run(input : String) -> String {
  Repr(@lib.parse(input)).to_string() catch {
    e => "ERROR: " + Repr(e).to_string()
  }
}

///|
fn main {

}
