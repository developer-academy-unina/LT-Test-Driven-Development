//
//  WalletView.swift
//  LT: Test Driven Development
//  Wallet
//
//  Created by Vasily Martin for Developer Academy
//

import SwiftUI

struct WalletView: View {
    @ObservedObject var wallet: Wallet
    @State var isAddingNewTransaction = false

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.cyan)
                    .frame(height: 200)
                    .padding(.horizontal)
                VStack {
                    Text(String(format: "€ %.2f", wallet.balance))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
            Text("Transactions")
                .font(.headline)
                .padding()
            List {
                ForEach(wallet.transactions) { transaction in
                    HStack {
                        Text(transaction.merchant)
                        Spacer()
                        Text(String(format: "%.2f", transaction.amount))
                        Button(
                            action: {
                                try? wallet.repeat(transaction: transaction)
                            },
                            label: {
                                Image(systemName: "doc.on.doc.fill")
                                    .foregroundColor(.blue)
                            }
                        )
                        .buttonStyle(.plain)
                    }
                }
            }
            .listStyle(.inset)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(
                    action: {
                        isAddingNewTransaction = true
                    },
                    label: {
                        Image(systemName: "bag.fill.badge.plus")
                    }
                )
            }
        }
        .sheet(isPresented: $isAddingNewTransaction) {
            AddTransactionView(wallet: wallet)
        }
        .navigationTitle("Balance")
    }
}

struct WalletView_Previews: PreviewProvider {
    static var wallet: Wallet = {
        let wallet = Wallet(balance: 200)
        wallet.transactions = [
            Transaction(merchant: "IKEA", amount: 100),
            Transaction(merchant: "SOLE", amount: 80)
        ]
        return wallet
    }()
    static var previews: some View {
        NavigationView {
            WalletView(wallet: wallet)
        }
    }
}
