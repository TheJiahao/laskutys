# finnish-invoice

A Typst template for Finnish invoice

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
