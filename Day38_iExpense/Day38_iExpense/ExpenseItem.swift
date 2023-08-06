//
//  ExpenseItem.swift
//  Day38_iExpense
//
//  Created by cem on 6.08.2023.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
