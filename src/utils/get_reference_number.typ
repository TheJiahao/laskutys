#import plugin("/rust_tools/rust_tools.wasm"): (
  get_reference_number as _get_reference_number,
)
#import "/src/utils/call_wasm.typ": call_wasm

#let get_reference_number(data) = {
  call_wasm(_get_reference_number, data)
}
