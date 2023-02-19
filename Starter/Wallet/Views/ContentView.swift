//
//  ContentView.swift
//  LT: Test Driven Development
//  Wallet
//
//  Created by Vasily Martin for Developer Academy
//

import SwiftUI

struct ContentView: View {
    @StateObject var wallet = Wallet(balance: 150)

    var body: some View {
        NavigationView {
            WalletView(wallet: wallet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
