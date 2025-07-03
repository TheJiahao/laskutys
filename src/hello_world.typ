#import plugin("/tools/tools.wasm"): hello_list, hello_world
#import "/src/utils/call_wasm.typ": call_wasm

#str(hello_world())
#call_wasm(hello_list, ("Hello world",))
