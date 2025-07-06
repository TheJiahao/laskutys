#let preprocess_items(
  items,
  default_vat_rate,
) = {
  assert(type(default_vat_rate) == decimal)

  for item in items {
    if "vat_rate" in items {
      assert(
        type(item.vat_rate) in (str, decimal),
        message: "Use decimal or str in vat_rate of items",
      )
    }

    assert(
      type(item.unit_price) in (str, decimal, int),
      message: "Use decimal, str or int in unit_price of items",
    )
  }

  items.map(item => {
    (
      ..item,
      vat_rate: decimal(item.at("vat_rate", default: default_vat_rate)),
      total_price: decimal(item.quantity) * decimal(item.unit_price),
      unit_price: decimal(item.unit_price),
      quantity: decimal(item.quantity),
    )
  })
}
