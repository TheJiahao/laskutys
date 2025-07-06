#import plugin("/rust_tools/rust_tools.wasm"): (
  check_reference_number, consolidate_vat, generate_bank_barcode,
  generate_reference_number,
)
#import "/src/utils/call_wasm.typ": call_wasm

#call_wasm(consolidate_vat, (("0.1", "1.5"), ("0.1", "1.5")))
#call_wasm(generate_reference_number, "1234567")
#call_wasm(check_reference_number, "RF661234567")
#call_wasm(check_reference_number, "RF66123456")
#call_wasm(generate_bank_barcode, (
  "100",
  "FI2112345600000785",
  "RF661234567",
  2025,
  1,
  1,
))
