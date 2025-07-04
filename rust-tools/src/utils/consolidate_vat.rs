use std::{collections::HashMap, str::FromStr};

use itertools::Itertools;
use rust_decimal::Decimal;
use wasm_minimal_protocol::{initiate_protocol, wasm_func};

use crate::utils::cbor_wrapper::{CBORError, cbor_wrapper};

initiate_protocol!();
#[wasm_func]
pub fn consolidate_vat(data: &[u8]) -> Result<Vec<u8>, CBORError> {
    let result = cbor_wrapper(data, |input: Vec<(String, String)>| {
        let decimals: Vec<(Decimal, Decimal)> = input
            .into_iter()
            .map(|(a, b)| (Decimal::from_str(&a).unwrap(), Decimal::from_str(&b).unwrap()))
            .collect();

        Ok(calculate_vat(&decimals))
    })?;

    Ok(result)
}

fn calculate_vat(data: &[(Decimal, Decimal)]) -> HashMap<Decimal, Decimal> {
    data.iter()
        .into_group_map_by(|(vat_rate, _)| vat_rate)
        .into_iter()
        .map(|(key, value)| (*key, value.iter().map(|(_, v)| v).sum()))
        .collect()
}

#[cfg(test)]
mod tests {
    use pretty_assertions::assert_eq;
    use rstest::rstest;
    use rust_decimal::{Decimal, dec};
    use std::collections::HashMap;

    use super::*;

    #[rstest]
    #[case(&[(dec!(0.10),dec!(3.50))], HashMap::from([(dec!(0.10),dec!(3.50))]))]
    #[case(&[(dec!(0.10),dec!(3.50)), (dec!(0.10),dec!(45))], HashMap::from([(dec!(0.10),dec!(48.50))]))]
    #[case(&[
                (dec!(0.10),dec!(0.30)),
                (dec!(0.14),dec!(2)),
                (dec!(0.10),dec!(0.10)),
                (dec!(0.10),dec!(1.30)),
                (dec!(25.5),dec!(0.99)),
                (dec!(25.5),dec!(0.70)),
            ],
            HashMap::from([(dec!(0.10),dec!(1.70)),(dec!(25.5),dec!(1.69)),(dec!(0.14),dec!(2))]))
    ]
    fn vat_is_calculated_correctly(
        #[case] data: &[(Decimal, Decimal)],
        #[case] expected: HashMap<Decimal, Decimal>,
    ) {
        assert_eq!(calculate_vat(data), expected)
    }
}
