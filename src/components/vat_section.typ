#import "/src/components/vat_row.typ": vat_row
#import "/src/utils/translate.typ": translate
#import "/src/utils/vat_calculation.typ": get_sum_row, preprocess

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
    strong(translate("total")),
    ..sum_row.map(strong),
  )
}
