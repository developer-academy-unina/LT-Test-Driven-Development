//
//  Wallet.swift
//  LT: Test Driven Development
//  Wallet
//
//  Created by Vasily Martin for Developer Academy
//

import Foundation

enum WalletError: LocalizedError {
    case unableToMakePayment
}

struct Transaction: Identifiable {
    let id = UUID()
    let merchant: String
    let amount: Double
}

class Wallet: ObservableObject {
    @Published var balance: Double
    @Published var transactions: [Transaction] = []

    init(balance: Double) {
        self.balance = balance
    }

    /// Makes a new payment
    /// Adds a new transaction in the transaction log and changes the balance for the amount of payment
    /// Throws error if not enough money to make payment
    /// - Parameters:
    ///   - merchant: name of merchant
    ///   - amount: amount of the payment
    func pay(to merchant: String, amount: Double) throws {
        let newBalance = balance - amount
        guard newBalance >= 0 else {
            throw WalletError.unableToMakePayment
        }
        let transaction = Transaction(
            merchant: merchant,
            amount: amount
        )
        transactions.append(transaction)
        balance = newBalance
    }

    /// Repeats payment using a specified transaction
    /// Adds a new transaction in the transaction log and changes the balance for the amount of payment
    /// Throws error if not enough money to make payment
    func `repeat`(transaction: Transaction) throws {
        try pay(to: transaction.merchant, amount: transaction.amount)
    }
}
