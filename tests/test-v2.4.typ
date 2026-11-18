#import "../payqr-swiss.typ": swiss-qr-bill

// Changes introduced by Version 2.4 of the Swiss Implementation Guidelines.
// The rejection of a QR reference in EUR stops compilation and cannot be shown here:
// see the "Invoices in EUR" section of the README.

#set page(paper: "a4", margin: 2.5cm)

#let creditor = (
  creditor-name: "Robert Schneider AG",
  creditor-street: "Rue du Lac",
  creditor-building: "1268",
  creditor-postal-code: "2501",
  creditor-city: "Biel",
  creditor-country: "CH",
  debtor-name: "Pia-Maria Rutschmann-Schnyder",
  debtor-street: "Grosse Marktgasse",
  debtor-building: "28",
  debtor-postal-code: "9400",
  debtor-city: "Rorschach",
  debtor-country: "CH",
)

#page[
  #heading[Romansh (language: "rm")]
  #place(bottom + center, dy: 2.5cm)[
    #swiss-qr-bill(
      ..creditor,
      account: "CH4431999123000889012",
      amount: 1949.75,
      currency: "CHF",
      reference-type: "QRR",
      reference: "210000000003139471430009017",
      additional-info: "Ordinaziun dals 15.10.2026",
      language: "rm",
    )
  ]
]

#page[
  #heading[Romansh from text.lang]
  #set text(lang: "rm")
  #place(bottom + center, dy: 2.5cm)[
    #swiss-qr-bill(
      ..creditor,
      account: "CH5800791123000889012",
      currency: "CHF",
      reference-type: "NON",
    )
  ]
]

#page[
  #heading[EUR with IBAN and Creditor Reference (SCOR)]
  #place(bottom + center, dy: 2.5cm)[
    #swiss-qr-bill(
      ..creditor,
      account: "CH5800791123000889012",
      amount: 199.95,
      currency: "EUR",
      reference-type: "SCOR",
      reference: "RF18539007547034",
      language: "en",
    )
  ]
]

#page[
  #heading[EUR with QR reference, transitional (allow-eur-qr-reference: true)]
  #place(bottom + center, dy: 2.5cm)[
    #swiss-qr-bill(
      ..creditor,
      account: "CH4431999123000889012",
      amount: 199.95,
      currency: "EUR",
      reference-type: "QRR",
      reference: "210000000003139471430009017",
      allow-eur-qr-reference: true,
      language: "en",
    )
  ]
]
