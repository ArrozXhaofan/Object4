//
//  BudgetView.swift
//  Object4
//
//  Created by Jeanpiere Laura on 15/12/24.
//

import SwiftUI
import SwiftData

struct BudgetView: View {
    
    @Bindable var value: Budget
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Query var incomes: [Income]
    @Query var expenses: [Expense]
    @Query var wishes: [Wish]
    
    var body: some View {
        ScrollView {
            VStack {
                
                VStack {
                    Text(String(format: "%.2f", value.savings))
                        .font(.system(size: 30, weight: .heavy))
                    Text("Saving")
                }
                
                VStack {
                    Rectangle()
                        .frame(width: 350, height: 40)
                        .foregroundStyle(.gray)
                        .overlay(alignment: .leading) {
                            HStack(spacing: 0) {
                                Rectangle()
                                    .foregroundStyle(.red)
                                    .frame(width: realPixel(data: value.totalExpenses,
                                                            total: value.totalIncomes),
                                           height: 40)
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .foregroundStyle(.green)
                                        .frame(width: realPixel(data: value.totalWishesMin,
                                                                total: value.totalIncomes))
                                        .zIndex(5)

                                    Rectangle()
                                        .foregroundStyle(.cyan)
                                        .frame(width: realPixel(data: value.totalWishesFix,
                                                                total: value.totalIncomes))
                                        .zIndex(2)

                                    Rectangle()
                                        .foregroundStyle(.orange)
                                        .frame(width: realPixel(data: value.totalWishesMax,
                                                                total: value.totalIncomes))
                                        .zIndex(0)
                                }
                            }
                            
                        }
                    Text("Total incomes \(String(format: "%.2f", value.totalIncomes))")
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
                .padding()
                
                
                VStack(spacing: 20) {
                    VStack {
                        ForEach(value.incomes, id: \.id) { cell in
                            NavigationLink(value: cell) {
                                IncomeRowCell(income: cell)
                                    .foregroundStyle(Color("textPrimary"))
                                    
                            }
                            .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 1)
                                        .onEnded { _ in
                                            let newArray = value.incomes.filter{$0.identifier != cell.identifier}
                                            withAnimation {
                                                value.incomes = newArray
                                            }
                                        }
                                )
                        }
                        VStack {
                            HStack {
                                Text("Total")
                                Spacer()
                                Text("")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.gray)
                                    
                            }
                            HStack {
                                Text("Expense fixed")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text(String(format: "%.2f", value.totalIncomes))
                                    .foregroundStyle(.green)
                                    .bold()
                            }
                        }
                        HStack {
                            Spacer()
                            Menu("Add new income", systemImage: "plus.circle") {
                                ForEach(incomes) { cell in
                                    Button {
                                        withAnimation {
                                            value.incomes.append(cell)
                                        }
                                    } label: {
                                        HStack {
                                            Text(cell.name)
                                        }
                                    }
                                }
                            }
                            .font(.footnote)
                        }
                    }
                    Divider()
                    VStack {
                        ForEach(value.expenses, id: \.id) { cell in
                            NavigationLink(value: cell) {
                                ExpenseRowCell(expense: cell)
                                    .foregroundStyle(Color("textPrimary"))
                            }
                            .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 1)
                                        .onEnded { _ in
                                            let newArray = value.expenses.filter{$0.identifier != cell.identifier}
                                            withAnimation {
                                                value.expenses = newArray
                                            }
                                        }
                                )
                        }
                        VStack {
                            HStack {
                                Text("Total")
                                Spacer()
                                Text("")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.gray)
                            }
                            HStack {
                                Text("Expense fixed")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text(String(format: "%.2f", value.totalExpenses))
                                    .foregroundStyle(.red)
                                    .bold()
                            }
                        }
                        HStack {
                            Spacer()
                            Menu("Add new expense", systemImage: "plus.circle") {
                                ForEach(expenses) { cell in
                                    Button {
                                        withAnimation {
                                            value.expenses.append(cell)
                                        }
                                    } label: {
                                        HStack {
                                            Text(cell.name)
                                        }
                                    }
                                }
                            }
                            .font(.footnote)
                        }
                    }

                    Divider()
                    //
                    VStack {
                        ForEach(value.wishes, id: \.id) { cell in
                            NavigationLink(value: cell) {
                                WishRowCell(wish: cell)
                                    .foregroundStyle(Color("textPrimary"))
                            }
                            .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 1)
                                        .onEnded { _ in
                                            let newArray = value.wishes.filter{$0.identifier != cell.identifier}
                                            withAnimation {
                                                value.wishes = newArray
                                            }
                                        }
                                )
                        }
                        VStack {
                            HStack {
                                Text("Total")
                                Spacer()
                                Text("")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(.gray)
                            }
                            HStack {
                                HStack {
                                    Text("Price mixed")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundStyle(.gray)
                                    HStack(spacing: 15) {
                                        
                                        HStack(spacing: 2) {
                                            Text("min")
                                            Text(String(format: "%2.f", value.totalWishesMin))
                                                .foregroundStyle(.yellow)
                                        }
                                        HStack(spacing: 2) {
                                            Text("max")
                                            Text(String(format: "%2.f", value.totalWishesMax))
                                                .foregroundStyle(.yellow)
                                        }
                                    }
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                                    
                                }
                                Spacer()
                                Text(String(format: "%.2f", value.totalWishesFix))
                                    .foregroundStyle(.cyan)
                                    .bold()
                            }
                        }
                        //
                        HStack {
                            Spacer()
                            Menu("Add new wish", systemImage: "plus.circle") {
                                ForEach(wishes) { cell in
                                    Button {
                                        withAnimation {
                                            value.wishes.append(cell)
                                        }
                                    } label: {
                                        HStack {
                                            Text(cell.nome)
                                        }
                                    }
                                }
                            }
                            .font(.footnote)
                        }
                        //
                    }
                    //
                    VStack {
                        HStack {
                            Text("Saving")
                            Spacer()
                            Text("")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.gray)
                        }
                        HStack {
                            Text("Saving flex")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.gray)
                            Spacer()
                            Text(String(format: "%.2f", value.savings))
                                .foregroundStyle(.yellow)
                                .fontWeight(.regular)
                        }
                    }
                    
                    Divider()
                    
                    Button {
                        context.delete(value)
                        dismiss()
                    } label: {
                        VStack{
                            Text("Delete")
                                .foregroundStyle(.red)
                                .padding()
                        }
                        .frame(width: 200)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.red, lineWidth: 0.5)
                        }
                    }
                    .padding()
                    
                }
            }
            .padding()
        }
        .navigationTitle(value.name)
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(for: Income.self) { value in
            IncomeDetailView(value: value)
        }
        .navigationDestination(for: Expense.self) { value in
            ExpenseDetailView(value: value)
        }
        .navigationDestination(for: Wish.self) { wish in
            AddWishView(data: wish)
        }
    }
    
    
    private func realPixel(data: Double, total: Double) -> Double {
        data > total ? 350 - (value.totalExpenses/value.totalIncomes * 350)  : (data/total * 350)
        //return (value / total) * 350
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        BudgetView(value: Budget.testObject())
    }
}


