#import "utils/translate.typ": translate
#import "utils/preprocess_items.typ": preprocess_items
#import "components/item_row.typ": item_row
#import "components/item_list.typ": item_list
#import "components/header.typ": header
#import "components/legal_entity.typ": legal_entity
#import "components/vat_section.typ": vat_section

#let invoice(
  lang: "en",
  currency: "€",
  date: datetime.today(),
  invoice_number: none,
  logo: none,
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
  items,
  // Default VAT rate
  vat_rate: decimal("0.255"),
) = {
  set text(lang: lang)

  header(date, invoice_number: invoice_number)

  grid(
    columns: (1fr, 1fr),
    align: (left + bottom, right + bottom),
    gutter: 2em,

    legal_entity(recipient, translate("purchaser")),
    [
      #if logo != none { image(logo, height: 5em) }

      #legal_entity(seller, translate("seller"))
    ],
  )

  let items = preprocess_items(items, vat_rate)

  item_list(items, currency)
  vat_section(items, currency)
}
