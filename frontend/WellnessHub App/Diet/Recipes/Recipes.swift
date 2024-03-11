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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width / 3), spacing: 16)], spacing: 16) {
                            ForEach(dietService.recipes) { recipe in
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
            
        //.onAppear {
        //    Task{
                
        //        do {
        //            try await dietService.fetchRecipesAsyncAwait()
        //        } catch {
        //            // Handle network errors
        //            print("Error fetching data:", error)
        //        }
        //    }
        //}
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData())
//}
