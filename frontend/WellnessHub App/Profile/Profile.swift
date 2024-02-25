//
//  profile.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct Profile: View {
    @StateObject private var authManager = AuthenticationManager.shared
    var body: some View {
        VStack(alignment: .leading,spacing: 50, content: {
            HStack(spacing: 95, content: {
                VStack(content: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
                        .font(.title2)
                        .padding(10)
                        .foregroundStyle(.teal)
                        .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                        .cornerRadius(70.0)
                    
                    
                    Text("Name")
                })
                .padding(.horizontal, 15)
                
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
                Text("Location:")

            })
            
            VStack {
                Button(action: {
                                }) {
                                    Text("Edit Profile")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.teal)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                                        

                                }
                                
                Button(action: {
                    authManager.logout()
                                }) {
                                    Text("Logout")
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.teal)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                                }
                            
            }
            Spacer()
            
        })
        .padding(.horizontal, 20)
        .padding(.top, 30)
        
    }
}

#Preview {
    Profile()
}
