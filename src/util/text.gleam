pub fn wrap(target: String, with affix: String) {
  affix <> target <> affix
}

pub fn inset(target: String, between affix: #(String, String)) {
  affix.0 <> target <> affix.1
}
