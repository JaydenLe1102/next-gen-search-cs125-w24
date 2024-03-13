//
//  Recipes.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI



struct Recipes: View {
    
    @EnvironmentObject var dietService: DietService
    @State private var error: Error? = nil
    
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false,content: {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3))
                ]) {
                    ForEach(dietService.recipes) { recipe in
                        RecipeModal(
                            name: recipe.title,
                            time: recipe.cookTime,
                            calories: String(recipe.calories),
                            description: recipe.instruction,
                            imageURL: recipe.image,
                            recipe: recipe
                        )
                        .padding(2)
                        .frame(minWidth: UIScreen.main.bounds.width / 2.25, maxWidth: .infinity)
                        
                    }
                }
        })
            

    }
}

//#Preview {
//    Recipes().
//}

