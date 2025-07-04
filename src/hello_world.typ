#import plugin("/rust-tools/rust_tools.wasm"): consolidate_vat
#import "/src/utils/call_wasm.typ": call_wasm

#call_wasm(consolidate_vat, (("0.1", "1.5"), ("0.1", "1.5")))
