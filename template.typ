#import "@preview/linguify:0.4.2": linguify, set-database


#let invoice(
  lang: "en",
  currency: "€",
  body,
) = {
  let translations = toml("translations.toml")
  set-database(translations)

  set text(lang: lang)
  [= #linguify("invoice")]
}
