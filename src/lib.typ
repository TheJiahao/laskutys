#import "utils/translate.typ": translate
#import "utils/preprocess_items.typ": preprocess_items
#import "components/item_row.typ": item_row
#import "components/item_list.typ": item_list
#import "components/header.typ": header
#import "components/legal_entity.typ": legal_entity
#import "components/vat_section.typ": vat_section
#import "components/payment_info.typ": payment_info
#import "utils/get_invoice_number.typ": get_invoice_number
#import plugin("/rust_tools/rust_tools.wasm"): get_reference_number
#import "utils/call_wasm.typ": call_wasm

#let invoice(
  lang: "en",
  date: datetime.today(),
  // Days to due date
  payment_terms: 14,
  invoice_number: auto,
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
  // Default VAT rate
  vat_rate: decimal("0.255"),
  payment: none,
  reference_number: auto,
  barcode: true,
  qrcode: true,
  items,
) = {
  set text(lang: lang)

  if invoice_number == auto {
    invoice_number = get_invoice_number(date)
  }

  if reference_number == auto {
    reference_number = call_wasm(get_reference_number, invoice_number)
  }

  let items = preprocess_items(items, vat_rate)
  let sum = items.map(item => item.total_price).sum()
  let due_date = date + duration(days: payment_terms)

  header(invoice_number, date)

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

  item_list(items)
  vat_section(items)
  payment_info(
    seller.name,
    sum,
    payment,
    due_date,
    reference_number,
    barcode: barcode,
  )
}
