#import plugin("/rust_tools/rust_tools.wasm"): get_bank_barcode
#import "/src/utils/call_wasm.typ": call_wasm
#import "@preview/tiaoma:0.3.0": code128

#let bank_barcode(
  amount,
  iban,
  reference_number,
  due_date,
  show_text: false,
) = {
  assert(type(due_date) == datetime)

  assert(
    iban.starts-with("FI"),
    message: "Bank barcode supports only Finnish IBAN",
  )

  let barcode = call_wasm(get_bank_barcode, (
    str(amount),
    iban,
    reference_number.replace(" ", ""),
    due_date.year(),
    due_date.month(),
    due_date.day(),
  ))
  code128(barcode, options: (
    height: 33.0,
    text-gap: 10.0,
    show-hrt: show_text,
  ))
}
