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
        VStack(content: {
            VStack(alignment: .center, content: {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .font(.title2)
                    .foregroundStyle(.teal)
                    .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                    .cornerRadius(70.0)

                Text("Name")
            })
            .padding(40)

            HStack(content: {
                VStack(alignment: .leading,spacing: 30, content: {
                    HStack( content: {
                        Text("Age:")
                        
                        Text("years old")
                            .foregroundColor(.secondary)
                    
                    })
                    
                    HStack(content: {
                        Text("Gender:")
                        
                    })
                    
                    HStack( content: {
                        Text("Weight:")
                        Text("lbs")
                            .foregroundColor(.secondary)
                    })
                    
                    HStack(content: {
                        Text("Height: ")
                    })
                            
                    
                    
                    HStack(content: {
                        Text("Goal:")
                    })
                    
                    HStack(content: {
                        Text("Activity Level:")
                    })
                })
                .padding(.horizontal,20)
                Spacer()
            })


            

            Button(action: {authManager.logout()}) {
                Text("Save Profile")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.teal)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
            }
            .padding(20)

            Spacer()
        })
        
    }
}

#Preview {
    Profile()
}
