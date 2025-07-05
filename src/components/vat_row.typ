#import "@preview/oxifmt:1.0.0": strfmt
#import "/src/utils/get_decimal_separator.typ": get_decimal_separator

#let vat_row(vat_rate, vat, total_with_vat, total_without_vat, lang) = {
  let strfmt = strfmt.with(fmt-decimal-separator: get_decimal_separator(lang))

  (
    [#strfmt("{:.2}", vat_rate * 100)],
    [#strfmt("{:.2}", total_without_vat)],
    [#strfmt("{:.2}", vat)],
    [#strfmt("{:.2}", total_with_vat)],
  )
}
