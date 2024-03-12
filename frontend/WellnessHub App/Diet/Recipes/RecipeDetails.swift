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
    @EnvironmentObject var dietService: DietService
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(alignment: .leading, spacing:15, content:{
//                Image(systemName: imageURL)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
                
                AsyncImage(url: URL(string: imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                } placeholder: {
                    // Provide a placeholder view, such as an activity indicator or a default image
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)

                }
                
                Text(name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
      
                HStack(spacing: 100, content:{
                    HStack(spacing: 25, content:{
                        Image(systemName: "fork.knife")
                        Text(calories)
                            .foregroundStyle(.black)
                    })
                    HStack(spacing: 25, content:{
                        Image(systemName: "clock")
                        Text(time)
                            .foregroundStyle(.black)
                    })
                })
    
                
                Text("Instruction: " + description)

            })
            .padding(.horizontal, 10)
            .frame(width:getRect().width)
        }
    )}
}

//#Preview {
//    Recipes()
//}
