#import "/src/utils/formatter.typ": formatter

#let item_row(data) = {
  (
    [#data.description],
    [#formatter("{:.2}", decimal(data.unit_price))],
    [#data.quantity],
    [#formatter("{:.2}", decimal(data.vat_rate) * 100)],
    [#formatter("{:.2}", decimal(data.total_price))],
  )
}
