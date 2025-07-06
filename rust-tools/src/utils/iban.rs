use wasm_minimal_protocol::{initiate_protocol, wasm_func};

use crate::utils::cbor_wrapper::{CBORError, cbor_wrapper};
use iban::Iban;

initiate_protocol!();

#[wasm_func]
pub fn iban(data: &[u8]) -> Result<Vec<u8>, CBORError> {
    cbor_wrapper(data, |s: String| Ok(Iban::parse(&s)?.to_string()))
}
