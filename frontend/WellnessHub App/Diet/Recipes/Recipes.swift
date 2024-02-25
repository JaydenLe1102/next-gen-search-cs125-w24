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
            VStack(alignment: .leading, spacing: 8){
                ForEach(recipes) { recipe in
                    HStack {
                        RecipeModal(
                            name: recipe.title, // Access first recipe in the group
                            time: "4h",
                            calories: recipe.calories,
                            description: "This is a description",
                            imageURL: recipe.image
                        )
                    }
                }


//                HStack{
//                    
//                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
//                    
//                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
//                    
//                }
        
            }
            .padding(.horizontal,20)
            
        })
        .onAppear {
            fetchRecipes()
        }
    }
}

#Preview {
    ContentView()
}
