#import "/src/utils/translate.typ": translate

#let header(invoice_number: none, date) = {
  let invoice_number = if invoice_number == none {
    date.display("[year padding:zero][month padding:zero][day padding:zero]1")
  } else { invoice_number }

  align(center)[
    = #translate("invoice") \##invoice_number
    #date.display()
  ]
}
