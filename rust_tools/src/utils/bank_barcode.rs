use bank_barcode::{Barcode, BuilderError};
use rust_decimal::Decimal;
use wasm_minimal_protocol::{initiate_protocol, wasm_func};

use crate::utils::cbor_wrapper::{CBORError, cbor_wrapper};

initiate_protocol!();

#[wasm_func]
pub fn generate_bank_barcode(data: &[u8]) -> Result<Vec<u8>, CBORError> {
    cbor_wrapper(
        data,
        |(amount, iban, reference_number, year, month, day): (
            Decimal,
            String,
            String,
            i32,
            u8,
            u8,
        )| {
            Ok(get_barcode(
                amount,
                &iban,
                &reference_number,
                year,
                month,
                day,
            )?)
        },
    )
}

fn get_barcode(
    amount: Decimal,
    iban: &str,
    reference_number: &str,
    year: i32,
    month: u8,
    day: u8,
) -> Result<String, BuilderError> {
    use rust_decimal::prelude::ToPrimitive;

    Ok(Barcode::builder()
        .euros(amount.trunc().to_u32().unwrap())
        .reference(reference_number)
        .account_number(iban)
        .calendar_due_date(year, month, day)
        .build()?
        .to_string())
}
