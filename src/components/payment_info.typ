#import "/src/utils/translate.typ": translate
#import "/src/utils/formatter.typ": formatter
#import plugin("/rust_tools/rust_tools.wasm"): (
  check_reference_number, iban as iban_constructor,
)
#import "/src/utils/call_wasm.typ": call_wasm
#import "/src/config.typ": CURRENCY
#import "/src/components/bank_barcode.typ": bank_barcode
#import "/src/components/bank_qrcode.typ": bank_qr_code

#let payment_info(
  beneficiary,
  amount,
  iban: none,
  bic: none,
  due_date,
  reference_number,
  // Show bank barcode
  barcode: true,
  // Show EPC QR code
  qrcode: true,
) = {
  assert(type(beneficiary) == str)
  assert(type(amount) == decimal)
  assert(type(due_date) == datetime)
  assert(type(reference_number) == str)

  assert(iban != none, message: "Missing IBAN")
  assert(bic != none, message: "Missing BIC")

  assert(
    call_wasm(check_reference_number, reference_number),
    message: "Invalid reference number",
  )

  let iban = call_wasm(iban_constructor, iban)

  grid(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    table(
      columns: 2,
      translate("beneficiary"), beneficiary,
      [IBAN], iban,
      [BIC], bic,
      translate("reference_number"), reference_number,
    ),
    if qrcode {
      bank_qr_code(
        amount,
        beneficiary,
        iban,
        bic,
        reference_number,
        due_date,
      )
    },
    table(
      columns: 2,
      translate("to_pay"), [*#formatter("{:.2}", amount) #CURRENCY*],
      translate("due_date"),
      due_date.display("[year]-[month padding:zero]-[day padding:zero]"),
    ),
  )

  if barcode {
    bank_barcode(amount, iban, reference_number, due_date)
  }
}
