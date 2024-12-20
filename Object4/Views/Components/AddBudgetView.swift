//
//  AddBudget.swift
//  Object4
//
//  Created by Jeanpiere Laura on 17/12/24.
//

import SwiftUI

enum SelectorNav: String, CaseIterable, Hashable {
    case budget = "Budget"
    case income = "Income"
    case expense = "Expense"
    case wish = "Wish"
}

struct AddBudgetView: View {
    
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        NavigationStack {
            
            Form {
                ForEach(SelectorNav.allCases, id: \.hashValue) { selector in
                    NavigationLink(value: selector) {
                        Text(selector.rawValue)
                    }
                }
            }
            .scrollDisabled(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: SelectorNav.self) { selector in
                switch selector {
                case .budget:
                    AddBudgetRegister()
                case .expense:
                    AddRegisterView(value: .expense)
                case .income:
                    AddRegisterView(value: .income)
                case .wish:
                    AddWishView(data: nil)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Add register")
                }
            }
            
        }
                                   
        
    }
}

#Preview {
    AddBudgetView()
}

struct AddBudgetRegister: View {
    
    @Environment(\.modelContext) var contexto
    @Environment(\.dismiss) var dismiss
    @State var onExitInsert: Bool = false
    @State var txtName: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("My personal budget", text: $txtName)
            } header: {
                Text("Budget name")
            } footer: {
                Text(Date.now.formatted(date: .complete, time: .shortened))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollDisabled(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add budget")
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    withAnimation {
                        if txtName != "" {
                            let budget = Budget(name: txtName,
                                                expenses: [],
                                                incomes: [],
                                                wishes: [])
                            
                            contexto.insert(budget)
                        }
                    }
                    dismiss()
                    dismiss()
                }
            }
        }
    }
}
