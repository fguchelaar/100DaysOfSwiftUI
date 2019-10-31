//
//  ContentView.swift
//  iExpense
//
//  Created by Frank Guchelaar on 30/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct CurrencyView: View {

    var amount = 0

    private var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: amount as NSNumber) ?? ""
    }

    var body: some View {
        Text(formattedAmount)
            .fontWeight(
                amount <= 10 ? .regular
                : amount <= 100 ? .semibold
                : .bold)
    }
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        CurrencyView(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddExpense.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
