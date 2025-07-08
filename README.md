# Laskutys

A Typst template for Finnish invoice

> [!NOTE]
> VAT-calculation might have rounding errors due to division.
> The errors are at most some cents.

Data format YAML:

```yaml
- description: Apple
  quantity: 10
  unit_price: "2"
  vat_rate: "0.14"

- description: Battery AA
  quantity: 2
  unit_price: "2"
  vat: "0.255"

- description: Newspaper
  quantity: 3
  unit_price: "10"
  vat_rate: "0.10"

- description: Phone
  quantity: 1
  unit_price: "10000"
  vat: "0"
```

> [!IMPORTANT]
> Pass `unit_price` and `vat_rate` as string, so that they can be converted to decimal without errors.
> This avoids rounding errors due to imprecision of floating-point numbers.

## License

The project is licensed under [MIT-license](/LICENSE).
Licenses of libraries used in this project are listed in [/licenses](/licenses/).
