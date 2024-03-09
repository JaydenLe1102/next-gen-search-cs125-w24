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
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading, spacing: 8){
                ForEach(dietService.recipes) { recipe in
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
            Task{
                
                do {
                    try await dietService.fetchRecipesAsyncAwait()
                } catch {
                    // Handle network errors
                    print("Error fetching data:", error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
