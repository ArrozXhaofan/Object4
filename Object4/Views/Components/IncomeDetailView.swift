//
//  ItemDetailView.swift
//  Object4
//
//  Created by Jeanpiere Laura on 16/12/24.
//

import SwiftUI

struct IncomeDetailView: View {
    
    @Bindable var value: Income
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var contexto
    
    @State var txtName: String = ""
    @State var txtAmount: String = ""
    @State var txtMoney: Money = .pen
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $value.name)
                TextField("Insert a amount", text: $txtAmount)
                    .keyboardType(.numberPad)
                    .onAppear{ txtAmount = String(value.amount) }
                    .onChange(of: txtAmount) { _, newValue in
                        value.amount = Double(newValue) ?? 0
                    }
            } header: {
                Text("Name & amount")
            }
            
            Section {
                ForEach(Money.allCases, id: \.rawValue) { caso in
                    Button {
                        value.money = caso
                    } label: {
                        HStack{
                            Text(caso.rawValue)
                                .foregroundStyle(Color("textPrimary"))
                            Spacer()
                            if value.money == caso {
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
                Button("Delete") {
                    contexto.delete(value)
                    dismiss()
                }
                .foregroundStyle(.red)
            } footer: {
                Text("No se podra recuperar los datos")
                    .foregroundStyle(.red)
            }
            
        }
        .scrollDisabled(true)
        .navigationTitle("Update Income")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        IncomeDetailView(value: Income(name: "Food", amount: 200, money: .pen))
    }
}
