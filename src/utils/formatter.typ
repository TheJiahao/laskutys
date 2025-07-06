#import "@preview/oxifmt:1.0.0": strfmt

#let get_decimal_separator(lang) = {
  let decimal_separators = ("fi": ",", "en": ".")

  decimal_separators.at(lang)
}

#let formatter(
  format,
  ..replacements,
) = context {
  strfmt(format, ..replacements, fmt-decimal-separator: get_decimal_separator(
    text.lang,
  ))
}

