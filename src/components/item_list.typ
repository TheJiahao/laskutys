#import "/src/utils/translate.typ": translate
#import "/src/components/item_row.typ": item_row
#import "/src/config.typ": CURRENCY

#let item_list(items) = {
  table(
    columns: (3fr, auto, auto, auto, 1.5fr),
    align: (left, right, right, right, right),
    fill: (_, y) => if y == 0 { gray.lighten(70%) },
    stroke: none,
    inset: 0.5em,

    table.header(
      translate("item"),
      [#translate("unit_price") (#CURRENCY)],
      translate(
        "quantity",
      ),
      [#translate("vat")-%],
      [#translate("total_with_tax") (#CURRENCY)],
    ),

    ..for item in items {
      item_row(item)
    },
  )
}
