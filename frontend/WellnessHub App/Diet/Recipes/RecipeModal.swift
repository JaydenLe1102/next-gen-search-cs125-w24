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
    

    
    var body: some View {
        VStack{
            
            Button(action: {
                isModalPresented.toggle()
            }){
                VStack(spacing: 15) {
                    Text(name)
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .fontWeight(.semibold)

                    
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
                    
//                    HStack(spacing: 15,content: {
                        HStack(spacing: 5,content: {
                            Image(systemName: "clock")
                                .foregroundColor(.red)
                            Text(time)
                                .foregroundStyle(.black)
                        })
                        
                        HStack(spacing: 5,content: {
                            Image(systemName: "fork.knife")
                                .foregroundColor(.red)
                            Text(calories)
                                .foregroundStyle(.black)
                        })
                        
                        
                        
//                    })
                    
                               
                }
                .padding(20)
                .frame(height: UIScreen.main.bounds.height / 3.5)
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
//    RecipeModal(
//        name: "Title",
//        time: "2 mins",
//        calories: 200,
//        description: "Instruction",
//        imageURL: recipe.image,
//        recipe: recipe
//    )
//}
