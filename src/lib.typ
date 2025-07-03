#import "utils/translate.typ": translate
#import "utils/preprocess_items.typ": preprocess_items
#import "@preview/oxifmt:1.0.0": strfmt
#import "utils/get_decimal_separator.typ": get_decimal_separator
#import "components/item_row.typ": item_row
#import "components/item_list.typ": item_list
#import "components/header.typ": header

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
  set text(lang: lang)

  header(date, invoice_number: invoice_number)

  grid(
    columns: (2fr, 2fr, auto),
    align: (left + top, right + top, right),
    gutter: 2em,
  )[
    *#translate("purchaser")*\
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

  item_list(preprocess_items(items), currency, lang)
}
