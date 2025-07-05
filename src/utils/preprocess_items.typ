#let preprocess_items(
  items,
  default_vat_rate,
) = {
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
