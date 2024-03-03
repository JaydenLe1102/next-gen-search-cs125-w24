//
//  UserInputs.swift
//  WellnessHub App
//
//  Created by BobaHolic on 3/1/24.
//

import SwiftUI

struct UserInputs: View {
    
    
    @State var weight: String
    @State var height: String
    @State var age: String
    @State var goal: String
    @State var gender: String
    @State var activityLevel: String
    @State var dietaryPreferences: String
    @State private var selectedGenderIndex = 0
    @State private var selectedGoalIndex = 0
    @State private var selectedActivityLvlIndex = 0
    
    @StateObject private var authManager = AuthenticationManager.shared

    
    let genders = ["Male", "Female", "Other"]
    let goals = ["Lose weight", "Gain weight", "Remain weight"]
    let activityLevels = ["Beginner", "Intermediate", "Professional"]

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

            VStack(alignment: .leading,spacing: 30, content: {
                HStack( content: {
                    Text("Age:")
                    TextField("Age", text: $age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 210)
                        .padding(.leading)
                    Text("years old")
                        .foregroundColor(.secondary)
                
                })
                
                HStack(content: {
                    Text("Gender:")
                    Picker("Gender", selection: $selectedGenderIndex) {
                        ForEach(0..<genders.count) { index in
                            Text(genders[index])
                        }
                    }
                })
                
                HStack( content: {
                    Text("Weight:")
                    TextField("Weight", text: $weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                    Text("lbs")
                        .foregroundColor(.secondary)
                })
                
                HStack(content: {
                    Text("Height: ")
                    TextField("Height", text: $height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                    Text("ft")
                        .foregroundColor(.secondary)
                })
                        
                
                
                HStack(content: {
                    Text("Goal:")
                    Section {
                        Picker("Goals", selection: $selectedGoalIndex) {
                            ForEach(0..<goals.count) { index in
                                Text(goals[index])
                            }
                        }
                    }
                })
                
                HStack(content: {
                    Text("Activity Level:")

                    Section {
                        Picker("Activity Levels", selection: $selectedActivityLvlIndex) {
                            ForEach(0..<activityLevels.count) { index in
                                Text(activityLevels[index])
                            }
                        }
                    }
                })
            })
            .padding()

            

            Button(action: {authManager.fakeLogin()}) {
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
    UserInputs(weight: "", height: "", age: "", goal: "", gender:"", activityLevel: "", dietaryPreferences: "")
}
