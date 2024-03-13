//
//  Exercise.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI

struct ExerciseModal: View {
    
    @EnvironmentObject var dietService: DietService
    @StateObject private var authManager = AuthenticationManager.shared
    
    @State private var isModalPresented = false
    
    @State private var addButtonDisabled = false
    @State private var removeButtonDisabled = true
    
    var id = UUID()
    var calories_burned: Int
    var instructions: String
    var length: String
    var title: String
    var imageURL: String
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(alignment: .leading, spacing:25, content:{
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
                
                Text(title)
                    .font(.title2)
                    .foregroundStyle(.black)
      
                HStack(spacing: 100, content:{
                    HStack(spacing: 10, content:{
                        Image(systemName: "flame")
                            .foregroundColor(.red)
                        Text("\(calories_burned) cal")
                            .foregroundStyle(.black)
                    })
                    HStack(spacing: 10, content:{
                        Image(systemName: "clock")
                            .foregroundColor(.red)
                        Text("\(length)")                            .foregroundStyle(.black)
                    })
                })
    
                
                Text("Instruction")
                    .font(.title2)
                Text("\(instructions)")
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray.opacity(0.2)))
            })
            .padding(20)
            .frame(width:getRect().width)
        }
    )}
}

#Preview {
    ExerciseModal(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks", imageURL: "photo")
}
