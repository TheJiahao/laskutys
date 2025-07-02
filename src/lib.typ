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
    name: "Recipient Name",
    street: "Street 123",
    zip_code: "01234",
    city: "City",
  ),
) = {
  let translations = toml("translations.toml")
  set-database(translations)

  set text(lang: lang)
  show heading.where(level: 1): align.with(center)

  [= #linguify("invoice")]

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
}
