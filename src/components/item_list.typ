#import "/src/utils/translate.typ": translate
#import "/src/components/item_row.typ": item_row
#import "/src/config.typ": CURRENCY

#let item_list(items) = {
  table(
    columns: (2fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right, right),
    table.header(
      translate("item"),
      translate("unit_price"),
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
