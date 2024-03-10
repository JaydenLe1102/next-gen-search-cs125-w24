//
//  profile.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

@MainActor
struct Profile: View {
    @StateObject private var authManager = AuthenticationManager.shared
    @EnvironmentObject var userData: UserData
    @State private var isModalPresented = false
    @State private var navigateBackToProfile = false

    var body: some View {
        NavigationView(content: {
            ScrollView(content: {
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

                                Text("\(userData.age) years old")
                                        .foregroundColor(.secondary)
                            
                            })
                            
                            HStack(content: {
                                Text("Gender:")
                                Text("\(userData.gender)")
                                    .foregroundColor(.secondary)
                                
                                
                            })
                            
                            HStack( content: {
                                Text("Weight:")
                                Text("\(userData.weight) lbs")
                                    .foregroundColor(.secondary)
                            })
                            
                            HStack(content: {
                                Text("Height: ")
                                Text("\(userData.height) ft")
                                    .foregroundColor(.secondary)
                            })
                                          
                            HStack(content: {
                                Text("Goal:")
                                Text("\(userData.goal)")
                                    .foregroundColor(.secondary)
                            })
                            
                            HStack(content: {
                                Text("Activity Level:")
                                Text("\(userData.activityLevel)")
                                    .foregroundColor(.secondary)
                            })
                        })
                        .padding(.horizontal,20)
                        Spacer()
                    })

                    

                    if authManager.isAuthenticated == true {
                        
                        //not working bc cmt out UserInputs().tag(0) in contentview!!
                        NavigationLink(destination: UserInputs(), isActive: $isModalPresented) {
                            EmptyView()
                        }
                        .hidden()
                        
                        
                        
                        Button(action: {
                            isModalPresented = true
                            print("hihi")
                            
                        }) {
                            Text("Edit profile")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.teal)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        Button(action: {
                            authManager.logout()
                        }) {
                            Text("Log out")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.teal)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                        }
                        .padding(.horizontal, 20)
                    }
                    else {
                        NavigationLink(destination: Profile(), isActive: $navigateBackToProfile) {
                            EmptyView()
                        }
                        .hidden()
                        Button(action: {
                            userData.saveProfile()
                            navigateBackToProfile = true
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.teal)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    }
                    Spacer()
                })  
        })
        .navigationBarBackButtonHidden(true)
    }
    
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData())
//}
