#import plugin("/rust_tools/rust_tools.wasm"): (
  get_reference_number as _get_reference_number,
)
#import "/src/utils/call_wasm.typ": call_wasm

#let get_reference_number(data) = {
  let reference_number = call_wasm(_get_reference_number, data)
  let formatted = reference_number
    .split("")
    .slice(1, -1)
    .chunks(4)
    .map(x => x.join(""))
    .join(" ")

  formatted
}
