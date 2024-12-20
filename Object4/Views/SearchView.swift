//
//  SearchView.swift
//  Object4
//
//  Created by Jeanpiere Laura on 16/12/24.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    
    @Query var incomes: [Income]
    @Query var expenses: [Expense]
    @Query var budgets: [Budget]
    @Query var wishes: [Wish]
    
    @State var txtSearch = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(incomes) { income in
                        NavigationLink(value: income, label: {
                            IncomeRowCell(income: income)
                        })
                    }
                    ForEach(expenses) { expense in
                        NavigationLink(value: expense, label: {
                            ExpenseRowCell(expense: expense)
                        })
                    }
                    ForEach(wishes) { wish in
                        WishRowCell(wish: wish)
                    }
                    ForEach(budgets) { budget in
                        BudgetRowCell(item: budget)
                    }
                }
            }
            .navigationDestination(for: Budget.self, destination: { value in
                BudgetView(value: value)
            })
            .navigationDestination(for: Expense.self) { expense in
                ExpenseDetailView(value: expense)
            }
            .navigationDestination(for: Income.self) { income in
                IncomeDetailView(value: income)
            }
            .navigationDestination(for: Wish.self) { wish in
                AddWishView(data: wish)
            }
            .navigationDestination(for: SelectorNav.self, destination: { pick in
                switch pick {
                case .income:
                    AddRegisterView(value: .income)
                case .expense:
                    AddRegisterView(value: .expense)
                case .budget:
                    AddBudgetRegister()
                case .wish:
                    AddWishView(data: nil)
                }
            })
            .navigationTitle("Search")
            .searchable(text: $txtSearch,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: Text("Write something")) {
                if (txtSearch.isEmpty) {
                    NavigationLink(value: SelectorNav.income) {
                        HStack{
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.green)
                            Text("Add Income")
                                .font(.body)
                        }
                    }.listRowSeparator(.hidden)
                    NavigationLink(value: SelectorNav.expense) {
                        HStack{
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.green)
                            Text("Add Expense")
                                .font(.body)
                        }
                    }.listRowSeparator(.hidden)
                    NavigationLink(value: SelectorNav.budget) {
                        HStack{
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.green)
                            Text("Add Budget")
                                .font(.body)
                        }
                    }
                    NavigationLink(value: SelectorNav.wish) {
                        HStack{
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.green)
                            Text("New Wish")
                                .font(.body)
                        }
                    }.listRowSeparator(.hidden)
                }
                else {
                    Text("Incomes")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                        .frame(width: 50, height: 10, alignment: .leading)
                    ForEach(incomes.filter{$0.name.lowercased().contains(txtSearch.lowercased())}) { income in
                        NavigationLink(value: income) {
                            IncomeRowCell(income: income)
                        }
                        .listRowSeparator(.hidden)
                    }
                    Text("Expenses")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    ForEach(expenses.filter{$0.name.lowercased().contains(txtSearch.lowercased())}) { expense in
                        NavigationLink(value: expense) {
                            ExpenseRowCell(expense: expense)
                        }
                        .listRowSeparator(.hidden)
                    }
                    Text("Budgets")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    ForEach(budgets.filter{$0.name.lowercased().contains(txtSearch.lowercased())}) { budget in
                        NavigationLink(value: budget) {
                            Text("\(budget.name)")
                        }
                        .listRowSeparator(.hidden)
                    }
                    Text("Wishes")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    ForEach(wishes.filter{$0.nome.lowercased().contains(txtSearch.lowercased())}) { wish in
                        WishRowCell(wish: wish)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            
        }
    }
}

#Preview(traits: .sampleData) {
    SearchView()
}

