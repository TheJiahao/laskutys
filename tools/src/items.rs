use crate::config::DEFAULT_VAT_RATE;
use ciborium::{de::from_reader, ser::into_writer};
use serde::{Deserialize, Serialize};
use wasm_minimal_protocol::*;

#[derive(Deserialize,Debug)]
pub struct RawItem {
    description: String,
    quantity: f32,
    vat_rate: Option<f32>,
    unit_price: f32,
}

#[derive(Serialize)]
pub struct Item {
    description: String,
    quantity: f32,
    vat_rate: f32,
    unit_price: f32,
    total_price: f32,
}

initiate_protocol!();

#[wasm_func]
pub fn preprocess_items(arg: &[u8]) -> Vec<u8> {
    let raw_items: Vec<RawItem> = from_reader(arg).unwrap();

    println!("{:?}", raw_items);

    let items: Vec<Item> = raw_items
        .iter()
        .map(|item| Item {
            description: item.description.clone(),
            quantity: item.quantity,
            vat_rate: item.vat_rate.unwrap_or(DEFAULT_VAT_RATE),
            unit_price: item.unit_price,
            total_price: item.quantity * item.unit_price,
        })
        .collect();

    let mut output = Vec::new();

    into_writer(&items, &mut output).unwrap();

    output
}
