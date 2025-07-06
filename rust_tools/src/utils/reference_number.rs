use crate::utils::cbor_wrapper::{CBORError, cbor_wrapper};
use iso_11649::RfCreditorReference;
use std::str::FromStr;
use wasm_minimal_protocol::{initiate_protocol, wasm_func};

initiate_protocol!();

#[wasm_func]
pub fn get_reference_number(data: &[u8]) -> Result<Vec<u8>, CBORError> {
    cbor_wrapper(data, |reference_number: String| {
        Ok(RfCreditorReference::new(&reference_number).to_string())
    })
}

#[wasm_func]
pub fn check_reference_number(data: &[u8]) -> Result<Vec<u8>, CBORError> {
    cbor_wrapper(
        data,
        |reference_number: String| match RfCreditorReference::from_str(&reference_number) {
            Ok(_) => Ok(true),
            Err(_) => Ok(false),
        },
    )
}
