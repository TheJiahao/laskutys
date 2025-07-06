#import "/src/utils/translate.typ": translate
#import "/src/utils/formatter.typ": formatter
#import plugin("/rust_tools/rust_tools.wasm"): check_reference_number, iban
#import "/src/utils/call_wasm.typ": call_wasm
#import "/src/config.typ": CURRENCY
#import "/src/components/bank_barcode.typ": bank_barcode

#let payment_info(
  recipient,
  amount,
  payment,
  due_date,
  reference_number,
) = {
  assert(type(recipient) == str)
  assert(type(amount) == decimal)
  assert(type(payment) == dictionary)
  assert(type(due_date) == datetime)
  assert(type(reference_number) == str)

  assert("bank" in payment, message: "Missing bank")
  assert("iban" in payment, message: "Missing IBAN")
  assert("bic" in payment, message: "Missing BIC")

  assert(
    call_wasm(check_reference_number, reference_number),
    message: "Invalid reference number",
  )

  let iban = call_wasm(iban, payment.iban)

  grid(
    columns: (1fr, 1fr),
    align: (left, right),
    table(
      columns: 2,
      translate("recipient"), recipient,
      translate("bank"), payment.bank,
      [IBAN], iban,
      [BIC], payment.bic,
      translate("reference_number"), reference_number,
    ),
    table(
      columns: 2,
      translate("to_pay"), [*#formatter("{:.2}", amount) #CURRENCY*],
      translate("due_date"),
      due_date.display("[day padding:zero].[month padding:zero].[year]"),
    ),
  )

  v(1fr)

  bank_barcode(amount, iban, reference_number, due_date)
}
