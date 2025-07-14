/// Converts monetary values to decimal and calculates various prices
///
/// -> array
#let preprocess_items(
  items,
  default_vat_rate,
) = {
  assert(type(default_vat_rate) == decimal)

  for item in items {
    if "vat_rate" in items {
      assert(
        type(item.vat-rate) in (str, decimal),
        message: "Use decimal or str in vat_rate of items",
      )
    }

    assert(
      type(item.unit-price) in (str, decimal, int),
      message: "Use decimal, str or int in unit_price of items",
    )
  }

  items.map(item => {
    let vat-rate = decimal(item.at("vat_rate", default: default_vat_rate))
    let quantity = decimal(item.quantity)
    let unit-price-with-vat = decimal(item.unit-price)
    let unit-price-without-vat = decimal(item.unit-price) / (1 + vat-rate)
    let total_price = quantity * unit-price-with-vat

    (
      description: item.description,
      vat-rate: vat-rate,
      total-price: total_price,
      unit-price-with-vat: unit-price-with-vat,
      unit-price-without-vat: unit-price-without-vat,
      quantity: quantity,
    )
  })
}
