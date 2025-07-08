#import "@preview/laskutys:1.0.0": DEFAULT_COLORS, invoice

#let data = yaml("data.yaml")

#invoice(
  iban: "FI2112345600000785",
  bic: "OKOYFIHH",
  seller: (
    name: "Company Oy",
    business_id: "1234567-8",
    street: "Street 123",
    zip_code: "01234",
    city: "City",
  ),
  recipient: (
    name: "Recipient Name",
    street: "Street 123",
    zip_code: "01234",
    city: "City",
  ),
  colors: (
    ..DEFAULT_COLORS,
    active: blue,
    bg_passive: teal.lighten(85%),
    passive: teal,
  ),
  data,
)
