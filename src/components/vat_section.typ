#import plugin("/rust-tools/rust_tools.wasm"): consolidate_vat
#import "/src/components/vat_row.typ": vat_row
#import "/src/utils/call_wasm.typ": call_wasm
#import "/src/utils/translate.typ": translate
#import "/src/utils/formatter.typ": formatter

#let preprocess(items) = {
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

  result
}

#let get_sum_row(data) = {
  let vat = data.map(row => row.at(1)).sum()
  let total_with_vat = data.map(row => row.at(2)).sum()
  let total_without_vat = total_with_vat - vat

  (
    total_without_vat,
    vat,
    total_with_vat,
  ).map(x => formatter("{:.2}", x))
}

#let vat_section(items, currency) = {
  let result = preprocess(items)
  let sum_row = get_sum_row(result)

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
      vat_row(..entry)
    },
    [Total],
    ..sum_row,
  )
}
