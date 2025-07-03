#let get_decimal_separator(lang) = {
  let decimal_separators = ("fi": ",", "en": ".")

  decimal_separators.at(lang)
}
