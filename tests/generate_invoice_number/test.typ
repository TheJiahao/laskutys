#import "/src/utils/get_invoice_number.typ": get_invoice_number

#assert(
  get_invoice_number(datetime(year: 2025, month: 1, day: 1))
    == "202501011",
)

#assert(
  get_invoice_number(datetime(year: 2025, month: 12, day: 15))
    == "202512151",
  message: "year-month-day order is correct",
)
