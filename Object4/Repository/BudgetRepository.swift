//
//  BudgetRepository.swift
//  Object4
//
//  Created by Jeanpiere Laura on 15/12/24.
//

import Foundation
import SwiftData

final class BudgetRepository {
    
    var database: ModelContainer
    
    @MainActor
    init(inDisk: Bool) {
        do {
            self.database = try Self.configureModelContainer(inDisk: inDisk)
            database.mainContext.insert(AppSettings(firstLaunch: true))
            try database.mainContext.save()
        } catch {
            fatalError("Error to configure database: \(error.localizedDescription)")
        }
    }
    
    static func configureModelContainer(inDisk: Bool) throws -> ModelContainer {
        let schema = Schema(
            [
                Budget.self,
                Income.self,
                Expense.self,
                Wish.self,
                AppSettings.self
            ]
        )
        let configuration = ModelConfiguration(isStoredInMemoryOnly: !inDisk)
        
        return try ModelContainer(for: schema, configurations: [configuration])
    }
}
