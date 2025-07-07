use bank_barcode::{Barcode, BuilderError};
use rust_decimal::prelude::ToPrimitive;
use rust_decimal::{Decimal, RoundingStrategy::MidpointAwayFromZero, dec};
use wasm_minimal_protocol::{initiate_protocol, wasm_func};

use crate::utils::cbor_wrapper::{CBORError, cbor_wrapper};

initiate_protocol!();

#[wasm_func]
pub fn get_bank_barcode(data: &[u8]) -> Result<Vec<u8>, CBORError> {
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
    let euros = amount.trunc().to_u32().unwrap();
    let cents = ((amount
        .fract()
        .round_dp_with_strategy(2, MidpointAwayFromZero))
        * dec!(100))
    .to_u8()
    .unwrap();

    Ok(Barcode::builder()
        .euros(euros)
        .cents(cents)
        .reference(reference_number)
        .account_number(iban)
        .calendar_due_date(year, month, day)
        .build()?
        .to_string())
}
