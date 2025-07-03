#import "@preview/linguify:0.4.2": linguify, set-database
#import "utils/preprocess_items.typ": preprocess_items
#import "@preview/oxifmt:1.0.0": strfmt


#let invoice(
  lang: "en",
  currency: "€",
  date: datetime.today(),
  invoice_number: none,
  seller: (
    name: "Company Oy",
    business_id: "1234567-8",
    logo: "logo.svg",
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
  items,
) = {
  let translations = toml("translations.toml")
  set-database(translations)
  let decimal_separators = ("fi": ",", "en": ".")
  let strfmt = strfmt.with(fmt-decimal-separator: decimal_separators.at(lang))

  set text(lang: lang)

  let invoice_number = if invoice_number == none {
    date.display("[year padding:zero][month padding:zero][day padding:zero]1")
  } else { invoice_number }

  align(center)[
    = #linguify("invoice") \##invoice_number
    #date.display()
  ]

  grid(
    columns: (2fr, 2fr, auto),
    align: (left + top, right + top, right),
    gutter: 2em,
  )[
    *#linguify("purchaser")*\
    #recipient.name\
    #recipient.street\
    #recipient.zip_code #recipient.city
  ][
    #seller.name\
    #seller.business_id\
    #seller.street\
    #seller.zip_code #seller.city
  ][
    #image(seller.logo, height: 5em)
  ]

  let items = preprocess_items(items)
  table(
    columns: (2fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, right, right, right, right),
    table.header(
      linguify("item"),
      linguify("unit_price"),
      linguify(
        "quantity",
      ),
      [#linguify("vat")-%],
      [#linguify("total_with_tax") (#currency)],
    ),
    ..for item in items {
      (
        [#item.description],
        [#strfmt("{:.2}", float(item.unit_price))],
        [#item.quantity],
        [#strfmt("{:.2}", float(item.vat_rate))],
        [#strfmt("{:.2}", float(item.total_price))],
      )
    },
  )
}
