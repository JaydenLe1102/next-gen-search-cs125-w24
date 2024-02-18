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
                    .foregroundStyle(Color.black)
      
                HStack(spacing: 100, content:{
                    Text(calories)
                        .foregroundStyle(Color.black)
                    
                    Text(time)
                        .foregroundStyle(Color.black)
                    })
                
                Text("Description: ")
                
                Text("Instruction: ")
//                RoundedRectangle(cornerRadius: 15)
//                    .frame(height: 200) // Set the height as needed
//                    .foregroundColor(Color.black.opacity(0.08))
//                
//                Button(action: {
//                                }) {
//                                    Text("See Menu")
//                                        .frame(maxWidth: .infinity)
//                                        .foregroundColor(Color.blue)
//                                        .padding()
//                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.blue.opacity(0.2)))
//                                }
            })
            .padding(.horizontal, 10)
            .frame(width:getRect().width)
        }
    )}
}

#Preview {
    RecipeDetails(name: "Recipe 1", time: "4 hours", calories: "300 cal",description:"This is a description", imageURL: "photo")
}
