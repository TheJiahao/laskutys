#import "/src/utils/preprocess_items.typ": preprocess_items

#let data_without_vat = (
  (
    description: "Apple",
    quantity: 3,
    unit_price: decimal("0.3"),
  ),
  (
    description: "Pineapple",
    quantity: 27,
    unit_price: decimal("0.7"),
  ),
)

#assert(
  preprocess_items(data_without_vat, decimal("0.14")).all(item => (
    item.vat-rate == decimal("0.14")
  )),
  message: "Default VAT rate is added",
)

#let data_with_vat = (
  (
    description: "Phone",
    quantity: 3,
    unit_price: "999.99",
  ),
  (
    description: "Pineapple",
    quantity: 27,
    unit_price: "0.7",
  ),
)

#assert(
  preprocess_items(data_with_vat, decimal("0.14")).all(item => (
    item.total-price == item.unit_price_with_vat * item.quantity
  )),
  message: "Total price is calculated",
)
