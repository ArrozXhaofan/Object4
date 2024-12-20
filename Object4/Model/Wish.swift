//
//  Wish.swift
//  Object4
//
//  Created by Jeanpiere Laura on 18/12/24.
//

import Foundation
import SwiftData

@Model
final class Wish {
    @Attribute var identifier: UUID
    var nome: String
    var descrizione: String?
    var minPrice: Double
    var price: Double
    var maxPrice: Double
    var money: Money
    
    init(identifier: UUID = UUID(),
         nome: String,
         descrizione: String? = nil,
         minPrice: Double,
         price: Double,
         maxPrice: Double,
         money: Money) {
        self.identifier = identifier
        self.nome = nome
        self.descrizione = descrizione
        self.minPrice = minPrice
        self.price = price
        self.maxPrice = maxPrice
        self.money = money
    }
}
