///|
fn bridge_error(error : Error) -> Json {
  match error {
    @lib.ValidationFailed(problems) =>
      Json::object({
        "accepted": false,
        "error": "configuration validation failed",
        "problems": problems.to_json(),
      })
    @lib.Located(message, position) =>
      Json::object({
        "accepted": false,
        "error": message,
        "position": position.to_json(),
      })
    e => Json::object({ "accepted": false, "error": Repr(e).to_string() })
  }
}
