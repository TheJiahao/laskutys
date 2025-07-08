# Laskutys

Laskutys is a template for making invoices satisfying (mostly) the [VAT invoice requirements](https://www.vero.fi/en/detailed-guidance/guidance/48090/vat-invoice-requirements/) by the Finnish Tax Administration.
Among other things, this template features:

- Finnish/English/Swedish translations
- VAT calculations by VAT base
- Optional [bank barcode](https://www.finanssiala.fi/wp-content/uploads/2021/03/Bank_bar_code_guide.pdf) (fi. Pankkiviivakoodi)
- Optional [EPC QR Code](https://www.finanssiala.fi/wp-content/uploads/2021/03/QR_code_in_credit_transfer_forms.pdf) (European Payment Council’s Quick Response Code)
- Invoice number generation from date
- [RF creditor reference](https://www.finanssiala.fi/wp-content/uploads/2024/04/structure-of-the-rf-creditor-reference-iso-11649.pdf) (ISO 11649) generation from invoice number
- Customizable colors

> [!NOTE]
> VAT-calculation might have rounding errors due to division.
> The errors are at most a few cents.

## Usage

See [/src/components/invoice.typ](https://github.com/TheJiahao/typst-finnish-invoice/blob/5fa8919f41abc17dc045f23db3bab746b2b28149/src/components/invoice.typ) for all parameters.

```typst
#import "@preview/laskutys:1.0.0": invoice

#let data = yaml("data.yaml")

#invoice(
  /// Optional, defaults to today
  date: datetime(year: 2025, month: 09, day: 30),
  /// Optional
  invoice_number: "0123456",
  /// Optional logo, displayed as is
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
  /// Recipient can also have business_id
  recipient: (
    name: "Recipient Name",
    street: "Street 123",
    zip_code: "01234",
    city: "City",
  ),
  /// fi: Finnish
  /// en: English (default)
  /// sv: Swedish
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

The data can also be defined directly in Typst as array:

```typst
#let data = (
  (
    description: "Apple",
    quantity: 10,
    unit_price: "2",
    vat_rate: "0.14",
  ),
  (
    description: "Battery AA",
    quantity: 2,
    unit_price: "2",
    vat_rate: "0.255",
  ),
  (
    description: "Item with default VAT",
    quantity: 3,
    unit_price: "10",
  ),
),
```

You can also use other [loader functions](https://typst.app/docs/reference/data-loading/) if they can produce an array in the same format.

## Examples

### Customize colors

```typst
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
    ..DEFAULT_COLORS
    active: blue,
    bg_passive: teal.lighten(85%),
    passive: teal,
  ),
  data,
)
```

![Changing colors](/docs/images/example_customize_colors.svg)

> [!TIP]
> The `DEFAULT_COLORS` is needed if you don't want to override all colors.

See Typst [documentation](https://typst.app/docs/reference/visualize/color/) for more colors and `/src/presets.typ` for configurable colors.
There are also some presets available, see [Color presets](/docs/color_presets.md).

### Change language

## Documentation

- [Development](/docs/development.md)
- [Architecture](/docs/architecture.md)
- [Color presets](/docs/color_presets.md)

## License

The project is licensed under [MIT-license](/LICENSE).
Licenses of libraries used in this project are listed in [/licenses](/licenses/).
