#import "/src/utils/get_bank_qr_payload.typ": get_bank_qr_payload

#assert.eq(
  get_bank_qr_payload(
    decimal("100"),
    "Ben",
    "FI79 4405 2020 0360 82",
    "SBANFIHH",
    "RF07 6633 2132 8510",
    datetime(year: 2025, month: 12, day: 3),
  ),
  (
    "BCD",
    "001",
    "1",
    "SCT",
    "SBANFIHH",
    "Ben",
    "FI7944052020036082",
    "EUR100.00",
    "",
    "RF07663321328510",
    "",
    "ReqdExctnDt/2025-12-03",
  ).join("\n"),
  message: "Spaces in IBAN and reference number are removed",
)

#assert.eq(
  get_bank_qr_payload(
    decimal("100"),
    "Ben",
    "FI7944052020036082",
    "SBANFIHH",
    "RF07663321328510",
    datetime(year: 2025, month: 12, day: 3),
  ),
  (
    "BCD",
    "001",
    "1",
    "SCT",
    "SBANFIHH",
    "Ben",
    "FI7944052020036082",
    "EUR100.00",
    "",
    "RF07663321328510",
    "",
    "ReqdExctnDt/2025-12-03",
  ).join("\n"),
  message: "Should work without spaces in IBAN and reference number",
)

#assert.eq(
  get_bank_qr_payload(
    decimal("100"),
    "Ben",
    "FI7944052020036082",
    "SBANFIHH",
    "RF07663321328510",
    datetime(year: 2025, month: 12, day: 3),
  ),
  (
    "BCD",
    "001",
    "1",
    "SCT",
    "SBANFIHH",
    "Ben",
    "FI7944052020036082",
    "EUR100.00",
    "",
    "RF07663321328510",
    "",
    "ReqdExctnDt/2025-12-03",
  ).join("\n"),
  message: "Should work without spaces in IBAN and reference number",
)

#assert.eq(
  get_bank_qr_payload(
    decimal("100"),
    "Ben",
    "FI5810171000000122",
    "NDEAFIHH",
    "RF07663321328510",
    datetime(year: 2025, month: 9, day: 3),
  ),
  (
    "BCD",
    "001",
    "1",
    "SCT",
    "NDEAFIHH",
    "Ben",
    "FI5810171000000122",
    "EUR100.00",
    "",
    "RF07663321328510",
    "",
    "ReqdExctnDt/2025-09-03",
  ).join("\n"),
  message: "Due date is in ISO format",
)

#assert.eq(
  get_bank_qr_payload(
    decimal("100.078"),
    "Ben",
    "FI5810171000000122",
    "NDEAFIHH",
    "RF07663321328510",
    datetime(year: 2025, month: 9, day: 3),
  ),
  (
    "BCD",
    "001",
    "1",
    "SCT",
    "NDEAFIHH",
    "Ben",
    "FI5810171000000122",
    "EUR100.08",
    "",
    "RF07663321328510",
    "",
    "ReqdExctnDt/2025-09-03",
  ).join("\n"),
  message: "Amount is rounded to 2 decimals up",
)

#assert.eq(
  get_bank_qr_payload(
    decimal("99.072"),
    "Ben",
    "FI5810171000000122",
    "NDEAFIHH",
    "RF07663321328510",
    datetime(year: 2025, month: 9, day: 3),
  ),
  (
    "BCD",
    "001",
    "1",
    "SCT",
    "NDEAFIHH",
    "Ben",
    "FI5810171000000122",
    "EUR99.07",
    "",
    "RF07663321328510",
    "",
    "ReqdExctnDt/2025-09-03",
  ).join("\n"),
  message: "Amount is rounded to 2 decimals down",
)
