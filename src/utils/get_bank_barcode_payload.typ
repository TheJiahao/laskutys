#import plugin("/rust_tools/rust_tools.wasm"): get_bank_barcode
#import "/src/utils/call-wasm.typ": call-wasm

/// -> str
#let get_bank_barcode_payload(amount, iban, reference_number, due_date) = {
  assert(type(due_date) == datetime)

  assert(
    iban.starts-with("FI"),
    message: "Bank barcode supports only Finnish IBAN",
  )

  call-wasm(get_bank_barcode, (
    str(amount),
    iban,
    reference_number.replace(" ", ""),
    due_date.year(),
    due_date.month(),
    due_date.day(),
  ))
}
