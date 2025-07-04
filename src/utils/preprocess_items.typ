#let preprocess_items(
  items,
  default_vat_rate,
) = {
  items.map(item => {
    (
      vat_rate: item.at("vat_rate", default: default_vat_rate),
      total_price: item.quantity * item.unit_price,
      ..item,
    )
  })
}
