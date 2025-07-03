use wasm_minimal_protocol::*;

pub mod config;
pub mod items;

pub use crate::items::preprocess_items;

initiate_protocol!();

#[wasm_func]
pub fn hello_world() -> Vec<u8> {
    b"Hello, world!".to_vec()
}
