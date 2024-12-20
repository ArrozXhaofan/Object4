//
//  SampleData.swift
//  Object4
//
//  Created by Jeanpiere Laura on 15/12/24.
//

import SwiftUI
import SwiftData

struct SampleData: PreviewModifier {
    
    static func makeSharedContext() async throws -> ModelContainer {
        
        let schema = Schema(
            [
                Budget.self,
                Income.self,
                Expense.self,
                Wish.self,
                AppSettings.self
            ]
        )
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        let container = try ModelContainer(for: schema, configurations: [configuration])
        
        container.mainContext.insert(Income.testobject1())
        container.mainContext.insert(Income.testobject2())
        container.mainContext.insert(Income.testobject3())
        container.mainContext.insert(Expense.testobject1())
        container.mainContext.insert(Expense.testobject2())
        container.mainContext.insert(Expense.testobject3())
        container.mainContext.insert(Budget.testObject())
        container.mainContext.insert(Wish.testobject1())
        
        try container.mainContext.save()
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
