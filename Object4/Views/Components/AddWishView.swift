//
//  AddWishView.swift
//  Object4
//
//  Created by Jeanpiere Laura on 19/12/24.
//

import SwiftUI

struct AddWishView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var contexto
    
    @State private var txtNome = ""
    @State private var txtDescricao = ""
    @State private var txtPrice = ""
    @State private var txtMinPrice = ""
    @State private var txtMaxPrice = ""
    @State private var txtMoney: Money = .euro
    
    var data: Wish?
        
    var body: some View {
        Form {
            Section {
                TextField("My wish", text: $txtNome)
                    .onChange(of: txtNome) { _, newValue in
                        data?.nome = newValue
                    }
            } header: {
                Text("Title")
            }
            Section {
                Picker("Currency", selection: $txtMoney) {
                    ForEach(Money.allCases, id: \.rawValue) { caso in
                        Text(caso.rawValue)
                            .tag(caso)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: txtMoney) { _, newValue in
                    data?.money = newValue
                }
                
                TextField("min price", text: $txtMinPrice)
                    .onChange(of: txtMinPrice) { _, newValue in
                        data?.minPrice = Double(newValue) ?? 0
                    }
                TextField("Price", text: $txtPrice)
                    .onChange(of: txtPrice) { _, newValue in
                        data?.price = Double(newValue) ?? 0
                    }
                TextField("max price", text: $txtMaxPrice)
                    .onChange(of: txtMaxPrice) { _, newValue in
                        data?.maxPrice = Double(newValue) ?? 0
                    }
            } header: {
                Text("Avarage price")
            } footer: {
                Text("Try to set the most realistic prices")
            }
            
            if let data = data {
                Section {
                    Button("Delete") {
                        contexto.delete(data)
                        dismiss()
                    }
                    .foregroundStyle(.red)
                } footer: {
                    Text("No se podra recuperar los datos")
                        .foregroundStyle(.red)
                }
            }
        }
        .onAppear {
            if let data = data {
                txtNome = data.nome
                txtMoney = data.money
                txtMinPrice = String(data.minPrice)
                txtPrice = String(data.price)
                txtMaxPrice = String(data.maxPrice)
            }
            
        }
        .scrollDisabled(true)
        .navigationTitle(data != nil ? "Update wish" : "Add wish")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if data == nil {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let data = Wish(nome: txtNome,
                                        minPrice: Double(txtMinPrice) ?? 0,
                                        price: Double(txtPrice) ?? 0,
                                        maxPrice: Double(txtMaxPrice) ?? 0,
                                        money: txtMoney)
                        contexto.insert(data)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddWishView(data: nil)
    }
}
