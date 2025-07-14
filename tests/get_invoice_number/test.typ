#import "/src/utils/get-invoice-number.typ": get-invoice-number

#assert(
  get-invoice-number(datetime(year: 2025, month: 1, day: 1)) == "202501011",
)

#assert(
  get-invoice-number(datetime(year: 2025, month: 12, day: 15)) == "202512151",
  message: "year-month-day order is correct",
)
