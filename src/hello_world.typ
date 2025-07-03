#import plugin("/tools/tools.wasm"): hello_string, hello_world
#import "/src/utils/call_wasm.typ": call_wasm

#str(hello_world())
#call_wasm(hello_string, "Hello world")
