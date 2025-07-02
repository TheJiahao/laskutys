#import "../src/lib.typ": *

#let data = yaml("data.yaml").items
#show: invoice(
  date: datetime(year: 2025, month: 1, day: 1),
  invoice_number: "0123456",
  data,
)
