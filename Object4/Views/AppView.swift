//
//  AppView.swift
//  Object4
//
//  Created by Jeanpiere Laura on 16/12/24.
//

import SwiftUI
import SwiftData

struct AppView: View {
    
    var body: some View {
        
        TabView {
            BudgetList()
                .tabItem {
                    VStack {
                        Image(systemName: "wallet.bifold")
                        Text("Budgets")
                    }
                }
            
            SearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
            
            Color.cyan
                .tabItem {
                    VStack {
                        Image(systemName: "peruviansolessign.arrow.trianglehead.counterclockwise.rotate.90")
                        Text("Search")
                    }
                }
        }
        
    }
}

#Preview(traits: .sampleData) {
    AppView()
}
