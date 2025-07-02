#import "../config.typ": DEFAULT_VAT_RATE

#let preprocess_items(
  items,
  default_vat_rate: DEFAULT_VAT_RATE,
) = {
  items.map(item => {
    (
      vat_rate: item.at("vat_rate", default: default_vat_rate),
      total_price: item.quantity * item.unit_price,
      ..item,
    )
  })
}
