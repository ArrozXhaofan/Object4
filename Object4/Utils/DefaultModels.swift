//
//  DefaultModels.swift
//  Object4
//
//  Created by Jeanpiere Laura on 16/12/24.
//

import Foundation

extension Wish {
    static func testobject1() -> Wish {
        Wish(nome: "Iphone 14",
             descrizione: "Phone pequeño",
             minPrice: 200,
             price: 500,
             maxPrice: 3500,
             money: .pen)
    }
}

extension Income {
    static func testobject1() -> Income {
        Income(name: "Software development",
               amount: 3000,
               money: .euro)
    }
    static func testobject2() -> Income {
        Income(name: "Rent payment",
               amount: 800,
               money: .pen)
    }
    static func testobject3() -> Income {
        Income(name: "Loans pen",
               amount: 500,
               money: .pen)
    }
}

extension Expense {
    static func testobject1() -> Expense {
        Expense(name: "Apartament",
                amount: 700, money: .euro)
    }
    static func testobject2() -> Expense {
        Expense(name: "Services",
                amount: 150,
                money: .euro)
    }
    static func testobject3() -> Expense {
        Expense(name: "Foot",
                amount: 200,
                money: .euro)
    }
}

extension Budget {
    static func testObject() -> Budget {
        Budget(name: "My personal budget",
               expenses: [Expense.testobject1(), Expense.testobject2(), Expense.testobject3()],
               incomes: [Income.testobject1()],
               wishes: [Wish.testobject1()])
    }
}
