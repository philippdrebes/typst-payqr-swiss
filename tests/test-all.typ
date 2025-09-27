#import "../payqr-swiss.typ": swiss-qr-bill

#set page(paper: "a4", margin: 2.5cm)

// Function to convert QR data lines to swiss-qr-bill parameters
#let data-to-params(lines) = {
  let params = (
    account: lines.at(3, default: ""),  // Field 4: Account/IBAN
    creditor-name: lines.at(5, default: ""),  // Field 6: Creditor name
    creditor-street: lines.at(6, default: ""),  // Field 7: Creditor street
    creditor-building: lines.at(7, default: ""),  // Field 8: Creditor building
    creditor-postal-code: lines.at(8, default: ""),  // Field 9: Creditor postal
    creditor-city: lines.at(9, default: ""),  // Field 10: Creditor city
    creditor-country: lines.at(10, default: "CH"),  // Field 11: Creditor country
    amount: if lines.at(18, default: "") != "" { float(lines.at(18)) } else { 0 },  // Field 19: Amount
    currency: lines.at(19, default: "CHF"),  // Field 20: Currency
    debtor-name: lines.at(21, default: ""),  // Field 22: Debtor name
    debtor-street: lines.at(22, default: ""),  // Field 23: Debtor street
    debtor-building: lines.at(23, default: ""),  // Field 24: Debtor building
    debtor-postal-code: lines.at(24, default: ""),  // Field 25: Debtor postal
    debtor-city: lines.at(25, default: ""),  // Field 26: Debtor city
    debtor-country: lines.at(26, default: "CH"),  // Field 27: Debtor country
    reference-type: lines.at(27, default: "NON"),  // Field 28: Reference type
    reference: if lines.at(28, default: "") != "" { lines.at(28) } else { none },  // Field 29: Reference
    additional-info: if lines.at(29, default: "") != "" { lines.at(29) } else { none },  // Field 30: Additional info
    billing-info: if lines.at(31, default: "") != "" { lines.at(31) } else { none },  // Field 32: Billing info
    language: "en",
    standalone: false
  )

  return params
}

// List of test cases
#let test-cases = (
  "Nr. 1 Datenschema englisch.txt",
  "Nr. 2 Datenschema englisch.txt",
  "Nr. 5 Datenschema englisch.txt",
  "Nr. 6 Datenschema englisch.txt",
  "Nr. 13 Datenschema englisch.txt",
  "Nr. 14 Datenschema englisch.txt",
  "Nr. 17 Datenschema englisch.txt",
  "Nr. 18 Datenschema englisch.txt",
  "Nr. 21 Datenschema englisch.txt",
  "Nr. 22 Datenschema englisch.txt",
  "Nr. 29 Datenschema englisch.txt",
  "Nr. 30 Datenschema englisch.txt",
  "Nr. 33 Datenschema englisch.txt",
  "Nr. 34 Datenschema englisch.txt",
  "Nr. 37 Datenschema englisch.txt",
  "Nr. 38 Datenschema englisch.txt",
  "Nr. 45 Datenschema englisch.txt",
  "Nr. 46 Datenschema englisch.txt"
)


// Generate QR bills for each test case
#for test-file in test-cases {
  let test-number = test-file.split(" ").at(1)

  page[
    #heading[Test Case #test-number]
    #text(size: 14pt)[Source: #test-file]
    #v(5mm)

    // Read and parse the data file
    #let file-content = read("data/" + test-file)
    #let lines = file-content.split("\n").map(l => l.split("→").at(1, default: l).trim())
    #let params = data-to-params(lines)

    // Debug: Show parsed data
    #text(size: 12pt)[
      *Function Parameters:* \
      Account: #params.account \
      Creditor: #params.creditor-name, #params.creditor-street #params.creditor-building, #params.creditor-postal-code #params.creditor-city \
      Debtor: #params.debtor-name, #params.debtor-street #params.debtor-building, #params.debtor-postal-code #params.debtor-city \
      Amount: #params.amount #params.currency \
      Reference: #params.reference-type - #params.reference \
      Additional Info: #params.additional-info \
      Billing Info: #params.billing-info \
    ]
    #v(5mm)

    #place(bottom + center, dy: 2.5cm)[
      #swiss-qr-bill(
        account: params.account,
        creditor-name: params.creditor-name,
        creditor-street: params.creditor-street,
        creditor-building: params.creditor-building,
        creditor-postal-code: params.creditor-postal-code,
        creditor-city: params.creditor-city,
        creditor-country: params.creditor-country,
        amount: params.amount,
        currency: params.currency,
        debtor-name: params.debtor-name,
        debtor-street: params.debtor-street,
        debtor-building: params.debtor-building,
        debtor-postal-code: params.debtor-postal-code,
        debtor-city: params.debtor-city,
        debtor-country: params.debtor-country,
        reference-type: params.reference-type,
        reference: params.reference,
        additional-info: params.additional-info,
        billing-info: params.billing-info,
        language: params.language,
      )
  ]
]

}
