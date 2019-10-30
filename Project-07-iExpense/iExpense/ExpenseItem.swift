//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Frank Guchelaar on 30/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
