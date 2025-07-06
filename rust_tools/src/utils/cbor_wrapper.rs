use std::error::Error;

use ciborium::{from_reader, into_writer};
use serde::{Serialize, de::DeserializeOwned};

/// An error from CBOR serialization or deserialization
pub type CBORError = Box<dyn Error>;

pub fn cbor_wrapper<I, O, F>(raw_data: &[u8], function: F) -> Result<Vec<u8>, CBORError>
where
    F: Fn(I) -> Result<O, CBORError>,
    O: Serialize,
    I: DeserializeOwned,
{
    let data: I = from_reader(raw_data)?;

    let mut output = Vec::new();
    into_writer(&function(data)?, &mut output)?;

    Ok(output)
}
