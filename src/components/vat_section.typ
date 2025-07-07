#import "/src/components/vat_row.typ": vat_row
#import "/src/utils/translate.typ": translate
#import "/src/utils/vat_calculation.typ": get_sum_row, preprocess
#import "/src/config.typ": CURRENCY

#let vat_section(items) = {
  let result = preprocess(items)
  let sum_row = get_sum_row(result)

  set text(size: 0.85em)

  table(
    columns: (auto, 1fr, auto, 1fr),
    inset: 0.5em,
    align: (right, right, right, right),
    stroke: none,

    table.header(
      [#translate("vat")~(%)],
      [#translate("price_without_vat")~(#CURRENCY)],
      [#translate("vat")~(#CURRENCY)],
      [#translate("price_with_vat")~(#CURRENCY)],
    ),
    table.hline(stroke: black.lighten(50%)),

    ..for entry in result {
      vat_row(..entry)
    },

    table.hline(stroke: black.lighten(50%)),
    strong(translate("total")), ..sum_row.map(strong),
  )
}
