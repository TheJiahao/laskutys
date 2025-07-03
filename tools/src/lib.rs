use wasm_minimal_protocol::*;

initiate_protocol!();

#[wasm_func]
pub fn hello_world() -> Vec<u8> {
    b"Hello, world!".to_vec()
}
