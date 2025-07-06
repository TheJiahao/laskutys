#import plugin("/rust-tools/rust_tools.wasm"): (
  check_reference_number, consolidate_vat, generate_reference_number,
)
#import "/src/utils/call_wasm.typ": call_wasm

#call_wasm(consolidate_vat, (("0.1", "1.5"), ("0.1", "1.5")))
#call_wasm(generate_reference_number, "1234567")
#call_wasm(check_reference_number, "RF661234567")
#call_wasm(check_reference_number, "RF66123456")
