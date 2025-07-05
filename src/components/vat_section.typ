#import plugin("/rust-tools/rust_tools.wasm"): consolidate_vat
#import "/src/components/vat_row.typ": vat_row
#import "/src/utils/call_wasm.typ": call_wasm
#import "/src/utils/translate.typ": translate

#let vat_section(items, currency, lang) = {
  let items = items.map(((vat_rate, total_price)) => (
    vat_rate,
    total_price,
  ).map(str))

  let result = call_wasm(consolidate_vat, items)
    .pairs()
    .sorted()
    .map(pair => pair.map(decimal))
    .map(((vat_rate, total_with_vat)) => {
      let total_without_vat = total_with_vat / (1 + vat_rate)
      let vat = total_with_vat - total_without_vat

      (vat_rate, vat, total_with_vat, total_without_vat)
    })
  let sum_row = result.fold((0, 0, 0), (accumulated, row) => {
    (
      accumulated.at(0) + row.at(0),
      accumulated.at(1) + row.at(1),
      accumulated.at(1) + row.at(2),
    )
  })

  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: (right, right, right, right),

    table.header(
      [#translate("vat")-%],
      [#translate("price_without_vat") (#currency)],
      [#translate("vat") (#currency)],
      [#translate("price_with_vat") (#currency)],
    ),

    ..for entry in result {
      vat_row(..entry, lang)
    },
    [Total],
  )
}
