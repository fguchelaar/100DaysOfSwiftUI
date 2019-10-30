//
//  ContentView.swift
//  iExpense
//
//  Created by Frank Guchelaar on 30/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

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
                        Text("\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
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
        let view = ContentView()
        view.expenses.items.append(ExpenseItem(name: "Name", type: "Type", amount: 100))
        return view
    }
}
