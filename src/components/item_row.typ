#import "@preview/oxifmt:1.0.0": strfmt
#import "/src/utils/get_decimal_separator.typ": get_decimal_separator

#let item_row(data, lang) = {
  let strfmt = strfmt.with(fmt-decimal-separator: get_decimal_separator(lang))

  (
    [#data.description],
    [#strfmt("{:.2}", float(data.unit_price))],
    [#data.quantity],
    [#strfmt("{:.2}", float(data.vat_rate))],
    [#strfmt("{:.2}", float(data.total_price))],
  )
}
