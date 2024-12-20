//
//  Budget.swift
//  Object4
//
//  Created by Jeanpiere Laura on 15/12/24.
//

import Foundation
import SwiftData

enum Money: String, Codable, CaseIterable {
    case euro = "€ EURO"
    case dollar = "$ DOLLAR"
    case pen = "S/. PEN"
}

@Model
final class Budget {
    @Attribute(.unique) var identifier: UUID
    var name: String
    var incomes: [Income]
    var expenses: [Expense]
    var lastChange: Date
    var wishes: [Wish]
    
    var totalExpenses: Double {
        var count: Double = 0
        for i in expenses {
            count += Double(i.amount)
        }
        return count
    }
    
    var totalIncomes: Double {
        var count: Double = 0
        for i in incomes {
            count += Double(i.amount)
        }
        return count
    }
    
    var totalWishesFix: Double {
        var count: Double = 0
        for i in wishes {
            count += Double(i.price)
        }
        return count
    }
    
    var totalWishesMin: Double {
        var count: Double = 0
        for i in wishes {
            count += Double(i.minPrice)
        }
        return count
    }
    
    var totalWishesMax: Double {
        var count: Double = 0
        for i in wishes {
            count += Double(i.maxPrice)
        }
        return count
    }
    
    var savings: Double {
        totalIncomes - (totalExpenses + totalWishesFix)
    }
    
    init(identifier: UUID = UUID(),
         name: String,
         expenses: [Expense],
         incomes: [Income],
         wishes: [Wish],
         lastChange: Date = .now) {
        self.identifier = identifier
        self.name = name
        self.expenses = expenses
        self.incomes = incomes
        self.lastChange = lastChange
        self.wishes = wishes
    }
}

