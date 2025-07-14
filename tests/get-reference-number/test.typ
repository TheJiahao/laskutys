#import "/src/utils/get-reference-number.typ": preprocess

#assert.eq(
  preprocess("RF97012345"),
  "RF9712345",
  message: "Leading zeros are removed",
)

#assert.eq(preprocess("RF54 1234"), "RF541234", message: "Spaces are removed")

#assert.eq(
  preprocess("RF33 0000 2348 236"),
  "RF332348236",
  message: "Leading zeros and spaces are removed",
)
