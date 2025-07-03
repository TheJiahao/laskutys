use ciborium::{from_reader, into_writer};
use wasm_minimal_protocol::*;

pub mod config;
pub mod items;

pub use crate::items::preprocess_items;

initiate_protocol!();

#[wasm_func]
pub fn hello_world() -> Vec<u8> {
    b"Hello, world!".to_vec()
}

#[wasm_func]
pub fn hello_string(arg: &[u8]) -> Vec<u8> {
    println!("{:?}", arg);

    let data: String = match from_reader(arg) {
        Ok(items) => items,
        Err(e) => {
            eprintln!("{:?}", e);
            return b"Error".to_vec();
        }
    };

    let mut output = Vec::new();

    into_writer(&data, &mut output).unwrap();

    output
}
