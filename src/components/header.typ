#import "/src/utils/translate.typ": translate

#let header(invoice_number, date) = {
  align(center)[
    = #translate("invoice") \##invoice_number
    #date.display()
  ]
}
