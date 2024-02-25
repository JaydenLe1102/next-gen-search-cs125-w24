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
    
    @State private var isModalPresented = false
    
    var body: some View {
        VStack{
            
            Button(action: {
                isModalPresented.toggle()
            }){
                VStack(spacing: 0) {
                    Text(name)
                        .foregroundStyle(.black)
                        .padding(.top)
                    
                    
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    } placeholder: {
                        // Provide a placeholder view, such as an activity indicator or a default image
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    
                    HStack(spacing: 20, content: {
                        Text(time)
                            .foregroundStyle(.black)
                        
                        Text(calories)
                            .foregroundStyle(.black)
                    })
                    .padding(.bottom)
                }
                .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                .cornerRadius(13)
     
            }

            .sheet(isPresented: $isModalPresented) {
                VStack{
                    RecipeDetails(name: name, time: time, calories: calories,description:"This is a description", imageURL: imageURL)
                }
                .padding()
            }
        }
    }
}

#Preview {
    Recipes()
}
