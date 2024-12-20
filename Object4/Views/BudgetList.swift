//
//  ContentView.swift
//  Object4
//
//  Created by Jeanpiere Laura on 15/12/24.
//

import SwiftUI
import SwiftData

struct BudgetList: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var budgets: [Budget]
    @Query private var appSetting: [AppSettings]
    
    @State var onAddBudget: Bool = false
    
    let tes = Budget.testObject()
    
    var wish = Wish.testobject1()
    
    var body: some View {
        NavigationStack {
            VStack {
                if budgets.isEmpty {
                    ContentUnavailableView("Wallet is empty",
                                           systemImage: "creditcard.trianglebadge.exclamationmark", description: Text("Add a budget to get started"))
                } else {
                    List {
                        
                        ForEach(budgets) { item in
                            BudgetRowCell(item: item)
                        }
                        .onDelete { array in
                            for i in array {
                                modelContext.delete(budgets[i])
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $onAddBudget, content: {
                AddBudgetView()
                    .presentationDetents([.height(480), .height(480)])
                    .interactiveDismissDisabled(true)
            })
            .navigationTitle("My Budgets")
            .navigationDestination(for: Budget.self) { budget in
                BudgetView(value: budget)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onAddBudget.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
        }
    }
}

#Preview(traits: .sampleData) {
    BudgetList()
}

struct BudgetRowCell: View {
    var item: Budget
    var body: some View {
        NavigationLink(value: item) {
            VStack(spacing: 10) {
                HStack {
                    Text(item.name)
                        .font(.title3)
                        .fontWeight(.thin)
                    Spacer()
                    Text(item.lastChange.formatted(date: .numeric, time: .shortened))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                HStack {
                    HStack(spacing: 15) {
                        HStack(spacing: 2) {
                            Text(String(format: "%2.f", item.totalIncomes))
                            Image(systemName: "arrow.up")
                                .foregroundStyle(.green)
                        }
                        HStack(spacing: 2) {
                            Text(String(format: "%2.f", item.totalExpenses))
                            Image(systemName: "arrow.down")
                                .foregroundStyle(.red)
                        }
                    }
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        if item.totalIncomes > item.totalExpenses {
                            Image(systemName: "digitalcrown.arrow.clockwise")
                            Text("Budget balanced")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundStyle(.yellow)
                        } else {
                            Image(systemName: "digitalcrown.down.clockwise")
                            Text("Budget not balanced")
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundStyle(.pink)
                        }
                    }
                    .foregroundStyle(.yellow)
                    
                }
            }
        }
    }
}

struct WishRowCell: View {
    var wish: Wish
    var body: some View {
        NavigationLink(value: wish) {
            VStack(spacing: 10) {
                HStack {
                    Text(wish.nome)
                        .font(.title3)
                        .fontWeight(.thin)
                    Spacer()
                    Text(wish.descrizione ?? "")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                HStack {
                    HStack(spacing: 15) {
                        
                        HStack(spacing: 2) {
                            Text("min")
                            Text(String(format: "%2.f", wish.minPrice))
                                .foregroundStyle(.yellow)
                        }
                        HStack(spacing: 2) {
                            Text("max")
                            Text(String(format: "%2.f", wish.maxPrice))
                                .foregroundStyle(.yellow)
                        }
                    }
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        HStack(alignment: .bottom, spacing: 4) {
                            Text(wish.money.rawValue)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Text(String(format: "%2.f", wish.price))
                                .font(.title3)
                                .foregroundStyle(.cyan)
                        }
                    }
                    
                }
            }
        }
    }
}
