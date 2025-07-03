// Content block containing name and other information of a legal entity i.e. seller or purchaser
#let legal_entity(
  entity,
  title,
) = {
  (
    [*#title*],
    entity.name,
    entity.at("business_id", default: none),
    entity.street,
    [#entity.zip_code #entity.city],
  )
    .filter(x => x != none)
    .join("\n")
}
