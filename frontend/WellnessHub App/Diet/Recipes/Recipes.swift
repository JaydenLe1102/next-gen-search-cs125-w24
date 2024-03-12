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
//        ScrollView(.horizontal, showsIndicators: false,content: {
//            HStack(content: {
//                            ForEach(dietService.recipes) { recipe in
//                                RecipeModal(
//                                    name: recipe.title,
//                                    time: recipe.cookTime,
//                                    calories: String(recipe.calories),
//                                    description: recipe.instruction,
//                                    imageURL: recipe.image
//                                )
//                                .frame(minWidth: 0, maxWidth: .infinity)
//                            }
//                        }
//             )
//        })
        
        ScrollView(.vertical, showsIndicators: false,content: {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3), spacing: 16)], spacing: 16) {
                            ForEach(dietService.recipes) { recipe in
                                RecipeModal(
                                    name: recipe.title,
                                    time: recipe.cookTime,
                                    calories: String(recipe.calories),
                                    description: recipe.instruction,
                                    imageURL: recipe.image,
                                    recipe: recipe
                                )
                                .frame(minWidth: 0, maxWidth: .infinity)
                            }
                        }
                        .padding(.vertical, 16)
        })
            

    }
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData(healthKitManager: HealthkitManager()))
//        .environmentObject(DietService())
//        .environmentObject(HealthkitManager())
//}

