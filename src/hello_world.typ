#import plugin("/rust-tools/rust_tools.wasm"): hello_list, hello_world
#import "/src/utils/call_wasm.typ": call_wasm

#str(hello_world())
#call_wasm(hello_list, (1.0, 2.0))
