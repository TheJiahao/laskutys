#import "utils/translate.typ": translate
#import "utils/preprocess_items.typ": preprocess_items
#import "components/item_row.typ": item_row
#import "components/item_list.typ": item_list
#import "components/header.typ": header
#import "components/vat_section.typ": vat_section
#import "components/payment_info.typ": payment_info
#import "utils/get_invoice_number.typ": get_invoice_number
#import "utils/get_reference_number.typ": get_reference_number

#let invoice(
  lang: "en",
  date: datetime.today(),
  // Contact information, displayd as is
  contacts: [],
  // Days to due date
  payment_terms: 14,
  invoice_number: auto,
  logo: none,
  seller: none,
  recipient: none,
  // Default VAT rate
  vat_rate: decimal("0.255"),
  iban: none,
  bic: none,
  // ISO 11649 reference number that begins with RF, only digits after RF are supported.
  // Leading zeros after check digits are removed.
  reference_number: auto,
  // Show bank barcode
  barcode: true,
  // Show EPC QR code
  qrcode: true,
  font: auto,
  items,
) = {
  set text(lang: lang, size: 12pt)
  set text(font: font) if (font != auto)
  set page(footer: contacts)

  if invoice_number == auto {
    invoice_number = get_invoice_number(date)
  }

  if reference_number == auto {
    reference_number = get_reference_number(invoice_number)
  }

  let items = preprocess_items(items, vat_rate)
  let sum = items.map(item => item.total_price).sum()
  let due_date = date + duration(days: payment_terms)

  header(
    invoice_number,
    date,
    recipient: recipient,
    seller: seller,
    logo: logo,
  )

  item_list(items)

  grid(
    columns: (1fr, 3fr),
    [], vat_section(items),
  )
  payment_info(
    beneficiary: seller.name,
    amount: sum,
    due_date: due_date,
    reference_number: reference_number,
    iban: iban,
    bic: bic,
    barcode: barcode,
    qrcode: qrcode,
  )
}
