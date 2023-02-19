//
//  AddTransactionView.swift
//  LT: Test Driven Development
//  Wallet
//
//  Created by Vasily Martin for Developer Academy
//

import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var wallet: Wallet
    @Environment(\.dismiss) var dismiss

    @State private var merchant = ""
    @State private var amount = 0.0

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Merchant")
                TextField("Merchant name", text: $merchant)
                    .textFieldStyle(.roundedBorder)
                Text("Amount")
                TextField("", value: $amount, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action:  {
                            dismiss()
                        },
                        label: {
                            Text("Cancel")
                        }
                    )
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: addPayment,
                        label: {
                            Text("Done")
                        }
                    )
                }
            }
            .navigationTitle("Add Transaction")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func addPayment() {
        try? wallet.pay(to: merchant, amount: amount)
        dismiss()
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView(wallet: Wallet(balance: 200))
    }
}
