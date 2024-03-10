//
//  Recipes.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI



struct Recipes: View {
    
    @StateObject var dietService = DietService() // Create and inject NetworkService
    @State private var recipes: [Recipe] = []
    @State private var error: Error? = nil
    
    func fetchRecipes() {
        dietService.fetchRecipes { result in
            switch result {
            case .success(let recipes):
                self.recipes = recipes
                self.error = nil
            case .failure(let error):
                self.recipes = []
                self.error = error
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3), spacing: 16)], spacing: 16) {
                            ForEach(recipes) { recipe in
                                RecipeModal(
                                    name: recipe.title,
                                    time: "4h",
                                    calories: recipe.calories,
                                    description: "This is a description",
                                    imageURL: recipe.image
                                )
                                .frame(minWidth: 0, maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal, 16)
        })
            
        .onAppear {
            fetchRecipes()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserData())
}
