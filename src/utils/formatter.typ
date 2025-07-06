#import "@preview/oxifmt:1.0.0": strfmt

#let get_decimal_separator(lang) = {
  let decimal_separators = ("fi": ",", "en": ".")

  decimal_separators.at(lang)
}

#let formatter(
  format,
  decimal_separator: auto,
  ..replacements,
) = context {
  let fmt_decimal_separator = if decimal_separator == auto {
    get_decimal_separator(
      text.lang,
    )
  } else { decimal_separator }

  strfmt(format, ..replacements, fmt-decimal-separator: fmt_decimal_separator)
}

