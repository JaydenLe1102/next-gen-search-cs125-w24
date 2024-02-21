//
//  profile.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 50, content: {
            HStack(spacing: 105, content: {
                VStack(content: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
                        .font(.title2)
                        .padding(10)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(70.0)
                    
                    Text("Name")
                })
                
                VStack(spacing: 40, content: {
                    VStack(content: {
                        Text("Weight")
                        Text("178 lbs")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    
                    VStack(content: {
                        Text("Goal")
                        Text("125 lbs")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                })
                
                
            })
            VStack(alignment: .leading,spacing: 20, content: {
                Text("Age:")
                Text("Gender:")
                Text("Height:")
                Text("Activity Level:")
                Text("Dietary Preferences:")
                Text("Health Goal:")
            })
            
            
            VStack {
                Button(action: {
                                }) {
                                    Text("Edit Profile")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(Color.blue)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.blue.opacity(0.2)))
                                }
                
                Button(action: {
                                }) {
                                    Text("Logout")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(Color.blue)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.blue.opacity(0.2)))
                                }
            }
            
            })
            .padding(.horizontal, 20)
        
        
        

    }
}

#Preview {
    Profile()
}
