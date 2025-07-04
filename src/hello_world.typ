#import plugin("/rust-tools/rust_tools.wasm"): (
  consolidate_vat, hello_list, hello_world,
)
#import "/src/utils/call_wasm.typ": call_wasm

#str(hello_world())
#call_wasm(consolidate_vat, (("0.1", "1.5"), ("0.1", "1.5")))
