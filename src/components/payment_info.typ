#import "/src/utils/translate.typ": translate
#import "/src/utils/formatter.typ": formatter

#let payment_info(
  recipient,
  amount,
  currency,
  payment,
  due_date,
  reference_number: none,
) = {
  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    table(
      columns: 2,
      translate("recipient"), recipient,
      translate("bank"), payment.at("bank"),
      [IBAN], payment.at("iban"),
      [BIC], payment.at("bic"),
      translate("reference_number"), reference_number,
    ),
    table(
      columns: 2,
      translate("to_pay"), [*#formatter("{:.2}", amount) #currency*],
      translate("due_date"),
      due_date.display("[day padding:zero].[month padding:zero].[year]"),
    ),
  )
}
