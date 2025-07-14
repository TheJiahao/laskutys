#import "/src/components/vat_row.typ": vat_row
#import "/src/utils/translate.typ": translate
#import "/src/utils/vat-calculation.typ": get-sum-row, preprocess
#import "/src/config.typ": CURRENCY, DEFAULT-COLORS, FONT-SIZES

/// -> content
#let vat_section(items, colors: DEFAULT-COLORS) = {
  let result = preprocess(items)
  let sum_row = get-sum-row(result)

  set text(size: FONT-SIZES.SMALL)

  table(
    columns: 4,
    inset: 0.5em,
    align: (right, right, right, right),
    stroke: none,

    table.header(
      [#translate("vat")~(%)],
      [#translate("price_without_vat")~(#CURRENCY)],
      [#translate("vat")~(#CURRENCY)],
      [#translate("price-with-vat")~(#CURRENCY)],
    ),
    table.hline(stroke: colors.passive),

    ..for entry in result {
      vat_row(..entry)
    },

    table.hline(stroke: colors.active),
    strong(translate("total")), ..sum_row.map(strong),
  )
}
