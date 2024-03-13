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
    @StateObject private var authManager = AuthenticationManager.shared

    
    @State private var addButtonDisabled = false
    @State private var removeButtonDisabled = true
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(alignment: .leading, spacing:25, content:{
                AsyncImage(url: URL(string: imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                }
                
                Text(name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.black)
      
                HStack(spacing: 100, content:{
                    HStack(spacing: 10, content:{
                        Image(systemName: "fork.knife")
                            .foregroundColor(.red)
                        Text(calories)
                            .foregroundStyle(.black)
                    })
                    HStack(spacing: 10, content:{
                        Image(systemName: "clock")
                            .foregroundColor(.red)
                        Text(time)
                            .foregroundStyle(.black)
                    })
                })
    
                
                Text("Instruction")
                    .font(.title2)
                Text("\(description)")
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray.opacity(0.2)))
                
                HStack(spacing: 8,content: {
                    
                    Button(action: {
                        // Add your button action here (e.g., increment calories)
                        print("Button tapped!")
                        removeButtonDisabled = false
                        addButtonDisabled = true
                        
                        dietService.addCaloriesConsume(calories: Double(calories)!, idToken: authManager.authToken)
//                            dietService.choosen_recipes.append(recipe)
                        
                    }) {
                        Text("Choose this recipe")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.teal)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                        
                    }
                    .buttonStyle(.plain)
                    .disabled(addButtonDisabled)
                    
                    
//                    Button(action: {
//                        // Add your button action here (e.g., increment calories)
//                        print("Button tapped remove calories!")
//                        removeButtonDisabled = true
//                        addButtonDisabled = false
//                        dietService.removeCaloriesConsume(calories: Double(calories)!, idToken: authManager.authToken)
////                            dietService.choosen_recipes.append(recipe)
//                        
//                    }) {
//                        Text("Choose this recipe")
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(.teal)
//                            .padding()
//                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
//                        
//                    }
//                    .buttonStyle(.plain)
//                    .disabled(removeButtonDisabled)
                })


            })
            .padding(20)
            .frame(width:getRect().width)
        }
    )}
}

//#Preview {
//    Recipes()
//}
