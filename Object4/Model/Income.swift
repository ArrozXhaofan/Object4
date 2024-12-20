//
//  Incomes.swift
//  Object4
//
//  Created by Jeanpiere Laura on 16/12/24.
//

import Foundation
import SwiftData

@Model
final class Income {
    @Attribute(.unique) var identifier: UUID
    var name: String
    var amount: Double
    var money: Money
    
    init(identifier: UUID = UUID(),
         name: String,
         amount: Double,
         money: Money) {
        self.identifier = identifier
        self.name = name
        self.amount = amount
        self.money = money
    }
}
