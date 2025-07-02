#import "@preview/linguify:0.4.2": linguify, set-database


#let invoice(
  lang: "en",
  currency: "€",
  seller: (
    name: "Company Oy",
    business_id: "1234567-8",
    logo: "logo.svg",
    street: "Street 123",
    zip_code: "01234",
    city: "City",
  ),
  recipient: (
    name: "Recipient",
    street: "Street 123",
    zip_code: "01234",
    city: "City",
  ),
  body,
) = {
  let translations = toml("translations.toml")
  set-database(translations)

  set text(lang: lang)
  grid(
    columns: (1fr, 1fr),
    align: (left, right),
  )[
    = #linguify("invoice")

    #recipient.name\
    #recipient.street\
    #recipient.zip_code #recipient.city

  ][
    #grid(columns: (auto, auto), gutter: 2em)[
      #align(horizon)[
        #seller.name\
        #seller.business_id\
        #seller.street\
        #seller.zip_code #seller.city
      ]
    ][
      #image(seller.logo, height: 3cm)
    ]
  ]
}
