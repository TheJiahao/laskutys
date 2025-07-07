#import "/src/utils/translate.typ": translate
#import "/src/components/item_row.typ": item_row
#import "/src/config.typ": COLORS, CURRENCY

#let item_list(items) = {
  show table.cell: c => if c.y == 0 {
    strong(c)
  } else { c }

  table(
    columns: (3fr, auto, auto, auto, 2fr),
    align: (left, right, right, right, right),
    fill: (_, y) => if calc.even(y) and y > 0 {
      COLORS.BG_PASSIVE
    },
    stroke: none,
    inset: (x: 0.75em, y: 0.5em),

    table.header(
      translate("item"),
      [#translate("unit_price")~(#CURRENCY)],
      translate(
        "quantity",
      ),
      [#translate("vat")~(%)],
      [#translate("total_with_tax")~(#CURRENCY)],
    ),
    table.hline(stroke: COLORS.ACTIVE),

    ..for item in items {
      item_row(item)
    },
  )
}
