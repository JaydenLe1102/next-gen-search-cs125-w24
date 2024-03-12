//
//  RecipeModal.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct RecipeModal: View {
    var id = UUID()
    var name: String
    var time: String
    var calories: String
    var description: String
    var imageURL: String
    var recipe: Recipe
    @EnvironmentObject var dietService: DietService
    @StateObject private var authManager = AuthenticationManager.shared
    
    @State private var isModalPresented = false
    
    @State private var addButtonDisabled = false
    @State private var removeButtonDisabled = true
    
    var body: some View {
        VStack{
            
            Button(action: {
                isModalPresented.toggle()
            }){
                VStack(spacing: 15) {
                    Text(name)
                        .foregroundStyle(.black)
                    
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        // Provide a placeholder view, such as an activity indicator or a default image
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)

                    }
                    
                    HStack(spacing: 8,content: {
                        HStack(spacing: 3,content: {
                            Image(systemName: "clock")
                            Text(time)
                                .foregroundStyle(.black)
                        })
                        
                        HStack(spacing: 3,content: {
                            Image(systemName: "fork.knife")
                            Text(calories)
                                .foregroundStyle(.black)
                        })
                        
                        
                        
                    })
                    
                    HStack(spacing: 8,content: {
                        
                        Button(action: {
                            // Add your button action here (e.g., increment calories)
                            print("Button tapped!")
                            removeButtonDisabled = false
                            addButtonDisabled = true
                            
                            dietService.addCaloriesConsume(calories: Double(calories)!, idToken: authManager.authToken)
//                            dietService.choosen_recipes.append(recipe)
                            
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                        .disabled(addButtonDisabled)
                        
                        
                        Button(action: {
                            // Add your button action here (e.g., increment calories)
                            print("Button tapped remove calories!")
                            removeButtonDisabled = true
                            addButtonDisabled = false
                            dietService.removeCaloriesConsume(calories: Double(calories)!, idToken: authManager.authToken)
//                            dietService.choosen_recipes.append(recipe)
                            
                        }) {
                            Image(systemName: "minus")
                                .foregroundColor(.black)
                        }
                        .buttonStyle(.plain)
                        .disabled(removeButtonDisabled)
                    })
           
                }
                .padding(10)
                .frame(height: UIScreen.main.bounds.height / 3)
                .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                .cornerRadius(13)
                
                
     
            }
            .sheet(isPresented: $isModalPresented) {
                VStack{
                    RecipeDetails(name: name, time: time, calories: calories,description: description, imageURL: imageURL)
                }
                .padding()
            }
        }
    }
}

//#Preview {
//    Recipes()
//}
