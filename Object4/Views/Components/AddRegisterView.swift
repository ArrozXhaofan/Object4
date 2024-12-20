//
//  AddRegisterView.swift
//  Object4
//
//  Created by Jeanpiere Laura on 17/12/24.
//

import SwiftUI

enum stateValue: String, Hashable {
    case income
    case expense
}

struct AddRegisterView: View {
    
    var value: stateValue
    
    @Environment(\.modelContext) var contexto
    @Environment(\.dismiss) var dismiss
    
    @State var txtTitle = ""
    @State var txtAmount = ""
    @State var stateMoney: Money = .euro
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $txtTitle)
                TextField("Insert a amount", text: $txtAmount)
                    .keyboardType(.numberPad)

            } header: {
                Text("Name & amount")
            }
            Section {
                ForEach(Money.allCases, id: \.rawValue) { caso in
                    Button {
                        stateMoney = caso
                    } label: {
                        HStack{
                            Text(caso.rawValue)
                                .foregroundStyle(Color("textPrimary"))
                            Spacer()
                            if stateMoney == caso {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                }
            } header: {
                Text("Money")
            } footer: {
                Text("Las monedas se iran implementando en futuras versiones.")
            }
            
            Section {
                Button {
                    let amount = Double(txtAmount)
                    
                    if value == .expense {
                        let data = Expense(name: txtTitle, amount: amount ?? 0, money: stateMoney)
                        contexto.insert(data)
                    } else {
                        let data = Income(name: txtTitle, amount: amount ?? 0, money: stateMoney)
                        contexto.insert(data)
                    }
                    dismiss()
                    
                } label: {
                    Text("Save")
                }

            }
        }
        .scrollDisabled(true)
        .navigationTitle("New \(value.rawValue)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        AddRegisterView(value: .expense)
    }
}
