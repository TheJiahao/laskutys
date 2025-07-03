#let get_decimal_separator() = context {
  let decimal_separators = ("fi": ",", "en": ".")
  let lang = text.lang

  decimal_separators.at(lang)
}
