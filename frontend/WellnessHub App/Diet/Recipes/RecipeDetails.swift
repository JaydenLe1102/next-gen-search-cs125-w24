//
//  RecipeDetails.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct RecipeDetails: View {
    var id = UUID()
    var name: String
    var time: String
    var calories: String
    var description: String
    var imageURL: String
    
    @State private var isModalPresented = false
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(alignment: .leading, spacing:15, content:{
                Image(systemName: imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Text(name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
      
                HStack(spacing: 100, content:{
                    Text(calories)
                        .foregroundStyle(.black)
                    
                    Text(time)
                        .foregroundStyle(.black)
                    })
                
                Text("Description: ")
                
                Text("Instruction: ")

            })
            .padding(.horizontal, 10)
            .frame(width:getRect().width)
        }
    )}
}

#Preview {
    RecipeDetails(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
}
