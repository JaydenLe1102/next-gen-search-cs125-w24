//
//  Recipes.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct Recipes: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(alignment: .leading, spacing: 8){
                //                    this part should be looping by restaurant's ID

                HStack{
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                    
                }
                
                HStack{
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                    
                }
                
                HStack{
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                    
                }
                
                HStack{
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                    
                    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
                }
        
            }
            .padding(.horizontal,20)
            
        })
    }
}

#Preview {
    ContentView()
}
