//
//  Expenses.swift
//  iExpense
//
//  Created by Frank Guchelaar on 30/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import Foundation

class Expenses: ObservableObject {

    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let expenseItems = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = expenseItems
                return
            }
        }

        self.items = []
    }

    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}
