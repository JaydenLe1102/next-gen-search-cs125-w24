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
                        .foregroundStyle(Color.black)
                        .padding(.top)
                    Image(systemName: imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    HStack(spacing: 20, content: {
                        Text(time)
                            .foregroundStyle(Color.black)
                        
                        Text(calories)
                            .foregroundStyle(Color.black)
                    })
                    .padding(.bottom)
                }
                .background(Color.black.opacity(0.08))
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
    RecipeModal(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
}
