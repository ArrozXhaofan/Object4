//
//  ExpenseRowCell.swift
//  Object4
//
//  Created by Jeanpiere Laura on 17/12/24.
//
import SwiftUI

struct ExpenseRowCell: View {
    @Bindable var expense: Expense
    var body: some View {
        VStack {
            HStack {
                Text(expense.name)
                Spacer()
                Text(expense.money.rawValue)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.gray)
            }
            HStack {
                Text("Expense fixed")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.gray)
                Spacer()
                Text(String(format: "%.2f", expense.amount))
                    .foregroundStyle(.red)
            }
        }
        
    }
}

struct IncomeRowCell: View {
    @Bindable var income: Income
    var body: some View {
        VStack {
            HStack {
                Text(income.name)
                Spacer()
                Text(income.money.rawValue)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.gray)
            }
            HStack {
                Text("Income fixed")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.gray)
                Spacer()
                Text(String(format: "%.2f", income.amount))
                    .foregroundStyle(.green)
            }
        }
        
    }
}

