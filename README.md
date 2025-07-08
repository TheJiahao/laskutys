# Laskutys

Laskutys is a template for making invoices satisfying (mostly) the [VAT invoice requirements](https://www.vero.fi/en/detailed-guidance/guidance/48090/vat-invoice-requirements/) by the Finnish Tax Administration.
Among other things, this template features:

- Finnish/English/Swedish translations
- VAT calculations by VAT base
- Optional [bank barcode](https://www.finanssiala.fi/wp-content/uploads/2021/03/Bank_bar_code_guide.pdf) (fi. Pankkiviivakoodi)
- Optional [EPC QR Code](https://www.finanssiala.fi/wp-content/uploads/2021/03/QR_code_in_credit_transfer_forms.pdf) (European Payment Council’s Quick Response Code)
- Invoice number generation from date
- [RF creditor reference](https://www.finanssiala.fi/wp-content/uploads/2024/04/structure-of-the-rf-creditor-reference-iso-11649.pdf) (ISO 11649) generation from invoice number

> [!NOTE]
> VAT-calculation might have rounding errors due to division.
> The errors are at most a few cents.

## Usage

```typst
#import "@preview/laskutys:1.0.0": invoice

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
```

YAML data of items:

```yaml
- description: Apple
  quantity: 10
  unit_price: "2"
  vat_rate: "0.14"

- description: Battery AA
  quantity: 2
  unit_price: "2"
  vat_rate: "0.255"

- description: Newspaper
  quantity: 3
  unit_price: "9.99"
  vat_rate: "0.10"

- description: Phone
  quantity: 1
  unit_price: "10000"
  vat_rate: "0"

- description: Item with default VAT
  quantity: 3
  unit_price: "10"
```

Output of the above code:
![Example generated invoice](/docs/images/thumbnail.svg)

> [!IMPORTANT]
> Pass `unit_price` and `vat_rate` as string, so that they can be converted to decimal without errors.
> This avoids rounding errors due to imprecision of floating-point numbers.

## Documentation

- [Development](/docs/development.md)

## License

The project is licensed under [MIT-license](/LICENSE).
Licenses of libraries used in this project are listed in [/licenses](/licenses/).
