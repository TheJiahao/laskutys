#import "/src/utils/preprocess-items.typ": preprocess-items

#let data-without-vat = (
  (
    description: "Apple",
    quantity: 3,
    unit-price: decimal("0.3"),
  ),
  (
    description: "Pineapple",
    quantity: 27,
    unit-price: decimal("0.7"),
  ),
)

#assert(
  preprocess-items(data-without-vat, decimal("0.14")).all(item => (
    item.vat-rate == decimal("0.14")
  )),
  message: "Default VAT rate is added",
)

#let data-with-vat = (
  (
    description: "Phone",
    quantity: 3,
    unit-price: "999.99",
  ),
  (
    description: "Pineapple",
    quantity: 27,
    unit-price: "0.7",
  ),
)

#assert(
  preprocess-items(data-with-vat, decimal("0.14")).all(item => (
    item.total-price == item.unit-price-with-vat * item.quantity
  )),
  message: "Total price is calculated",
)
