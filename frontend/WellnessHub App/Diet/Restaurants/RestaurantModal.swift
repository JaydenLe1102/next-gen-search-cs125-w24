//
//  Restaurant.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/14/24.
//

import SwiftUI

struct RestaurantModal: View {
    var id = UUID()
    var name: String
    var rating: Double
    var status: String
    var location: String
    var imageURL: String
    
    @State private var isModalPresented = false
    
    var body: some View {
        VStack{
            Button(action: {
                isModalPresented.toggle()
            }){
                HStack(spacing: 0) {
                    Image(systemName: imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        Text(name)
                            .foregroundStyle(.black)
                        HStack {
                            ForEach(0..<Int(rating), id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                            
                            if rating - Double(Int(rating)) > 0 {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundStyle(.yellow)
                            }
                            
                            ForEach(0..<5 - Int(ceil(rating)), id: \.self) { _ in
                                Image(systemName: "star")
                                    .foregroundStyle(.yellow)
                            }
                        }
                        
                        if status == "Open" {
                            Text(status).foregroundColor(.green)
                        }
                        else {
                            Text(status).foregroundColor(.red)
                        }
                            
                        Text(location)
                            .foregroundStyle(.black)
                    })
                    .padding()
                }
//                .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                .cornerRadius(13)
                .overlay(
                            Rectangle()
                                .frame(height: 0.35)
                                .foregroundColor(Color.gray)
                                .offset(y: 82)
                                .edgesIgnoringSafeArea(.top)
                        )
                
            }
            .padding(.horizontal)
            .sheet(isPresented: $isModalPresented) {
                VStack{
                    RestaurantDetails(name: name, rating: rating, status: status, location: location, description:"This is a description", imageURL: imageURL)
                }
                .padding()
            }
        }
    }
}

#Preview {
    Restaurants()
}


