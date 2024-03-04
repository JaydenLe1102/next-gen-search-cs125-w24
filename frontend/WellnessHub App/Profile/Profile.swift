//
//  profile.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct Profile: View {
    @StateObject private var authManager = AuthenticationManager.shared
    @EnvironmentObject var userData: UserData
    @State private var isModalPresented = false

    
    let genders = ["Male", "Female", "Other"]
    let goals = ["Lose weight", "Gain weight", "Remain weight"]
    let activityLevels = ["Beginner", "Intermediate", "Professional"]
    
    func saveProfile() {
        // Save user inputs into UserData object
        // You can add more logic/validation as needed
        userData.weight = userData.weight.trimmingCharacters(in: .whitespacesAndNewlines)
        userData.height = userData.height.trimmingCharacters(in: .whitespacesAndNewlines)
        userData.age = userData.age.trimmingCharacters(in: .whitespacesAndNewlines)
        userData.goal = goals[userData.selectedGoalIndex]
        userData.gender = genders[userData.selectedGenderIndex]
        userData.activityLevel = activityLevels[userData.selectedActivityLvlIndex]
        
//        userData.updateUserData(weight: userData.weight, height: userData.height, age: userData.age, goal: userData.goal, gender: userData.gender, activityLevel: userData.activityLevel, dietaryPreferences: "dietatry update", selectedGenderIndex: userData.selectedGenderIndex, selectedGoalIndex: userData.selectedGoalIndex, selectedActivityLvlIndex: userData.selectedActivityLvlIndex)

        // Print to check if data is updated
        print("Printing hello world")
        print("Saved Profile:")
        print("Age: \(userData.age)")
        print("Gender: \(userData.gender)")
        print("Weight: \(userData.weight) lbs")
        print("Height: \(userData.height) ft")
        print("Goal: \(userData.goal)")
        print("Activity Level: \(userData.activityLevel)")
    }

    
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
                        Text("\(userData.weight) ft")
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
                
                NavigationLink(destination: UserInputs(), isActive: $isModalPresented) {
                                        EmptyView()
                                    }
                                    .hidden()
                
                Button(action: {
                    isModalPresented = true
                }) {
                    Text("Edit profile")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.teal)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                }
                .padding(20)
                Button(action: {authManager.logout()}) {
                    Text("Log out")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.teal)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                }
                .padding(20)
            }
            else {
                Button(action: {saveProfile()}) {
                    Text("Save Profile")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.teal)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                }
                .padding(20)
            }

            

            Spacer()
        })
        
    }
}

#Preview {
    Profile()
}
