#import "../src/lib.typ": *

#let data = yaml("data.yaml")

#invoice(
  date: datetime(year: 2025, month: 09, day: 30),
  invoice_number: "0123456",
  logo: image("/src/logo.svg", height: 4em),
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
  lang: "fi",
  footnotes: [Company Oy, Phone: +358 123 4567, Email: sales.person\@company.com],
  data,
)
