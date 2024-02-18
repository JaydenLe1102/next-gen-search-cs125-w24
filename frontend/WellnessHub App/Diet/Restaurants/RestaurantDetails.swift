//
//  Restaurant.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/14/24.
//

import SwiftUI

struct RestaurantDetails: View {
    var id = UUID()
    var name: String
    var rating: Double
    var status: String
    var location: String
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
                HStack {
                    ForEach(0..<Int(rating), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundStyle(Color.yellow)
                    }
                    
                    if rating - Double(Int(rating)) > 0 {
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundStyle(Color.yellow)
                    }
                    
                    ForEach(0..<5 - Int(ceil(rating)), id: \.self) { _ in
                        Image(systemName: "star")
                            .foregroundStyle(Color.yellow)
                    }
                }
                
                
                if status == "Open" {
                    HStack(content: {
                        Text(status).foregroundColor(Color.green)
                        Text("Hours")
                    })
                }
                else {
                    Text(status).foregroundColor(Color.red)
                }
                
                Text(location)
                    .foregroundStyle(Color.black)
                
                Text("Address: ")
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 200) // Set the height as needed
                    .foregroundColor(Color.black.opacity(0.08))
                
                Button(action: {
                                }) {
                                    Text("See Menu")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(Color.blue)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.blue.opacity(0.2)))
                                }
            })
            .padding(.horizontal, 10)
            .frame(width:getRect().width)
        }
    )}
}

#Preview {
    RestaurantDetails(name: "Restaurant 1", rating: 3, status: "Open", location: "Irvine, CA",description:"This is a description", imageURL: "photo")
}

