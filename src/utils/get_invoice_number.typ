#let get_invoice_number(date) = {
  date.display(
    "[year padding:zero][month padding:zero][day padding:zero]1",
  )
}
