//
//  AddCurrencyView.swift
//  Currency SwiftUI
//
//  Created by wickedRun on 2021/05/24.
//

import SwiftUI

struct AddCurrencyView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(userData.allCurrencies) { currency in
                return HStack {
                    Button(action: { select(currency) }) {
                        Text("\(currency.code) - \(currency.name)")
                    }
                    Spacer()
                    if isSelected(currency) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Add Currency"))
    }
    
    private func select(_ currency: Currency) {
        if userData.userCurrency.map({ $0.code }).contains(currency.code) {
            userData.userCurrency.removeAll { $0.code == currency.code }
        } else {
            userData.userCurrency.append(currency)
        }
    }
    
    private func isSelected(_ currency: Currency) -> Bool {
        return userData.userCurrency.map({ $0.code }).contains(currency.code)
    }
}

struct AddCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        AddCurrencyView()
    }
}
