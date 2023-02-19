//
//  WalletTests.swift
//  Workshop: Make It Testable
//  WalletTests
//
//  Created by Vasily Martin for Developer Academy
//


import XCTest
@testable import Wallet

class WalletTests: XCTestCase {
    var wallet: Wallet!
    let initialBalance = 150.0

    override func setUpWithError() throws {
        try super.setUpWithError()
        wallet = Wallet(balance: initialBalance)
    }

    func testWalletInitialBalance() {
        XCTAssertEqual(
            wallet.balance,
            initialBalance,
            "The wallet has incorrect balance"
        )
    }

    func testWalletBalanceAfterTransaction() {
        let merchant = "IKEA"
        let amount = 20.0
        XCTAssertNoThrow(try wallet.pay(to: merchant, amount: amount))
        XCTAssertEqual(
            wallet.balance,
            initialBalance - amount,
            "Incorrect balance in wallet after payment"
        )
    }

    func testTransactionGreaterThanBalance() {
        let amountGreaterThanBalance = 170.0
        XCTAssertThrowsError(
            try wallet.pay(to: "IKEA", amount: amountGreaterThanBalance),
            "Negative balance should throw error"
        )
    }

    func testTransactionWasLogged() {
        let merchant = "IKEA"
        let amount = 20.0
        try? wallet.pay(to: merchant, amount: amount)
        let lastTransaction = wallet.transactions.last
        XCTAssertNotNil(lastTransaction)
        XCTAssertEqual(lastTransaction?.merchant, merchant)
        XCTAssertEqual(lastTransaction?.amount, amount)
    }

    func testRepeatedTransactionWasLogged() {
        let transaction = Transaction(merchant: "IKEA", amount: 20.0)
        try? wallet.pay(to: transaction.merchant, amount: transaction.amount)
        try? wallet.repeat(transaction: transaction)
        let numberOfTransactions = wallet.transactions.filter {
            $0.merchant == transaction.merchant && $0.amount == transaction.amount
        }.count
        XCTAssertGreaterThanOrEqual(numberOfTransactions, 2)
    }
}
