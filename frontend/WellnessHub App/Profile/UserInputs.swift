//
//  UserInputs.swift
//  WellnessHub App
//
//  Created by BobaHolic on 3/1/24.
//

import SwiftUI

class UserData: ObservableObject {

    // User data properties
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var age: String = ""
    @Published var goal: String = ""
    @Published var gender: String = ""
    @Published var activityLevel: String = ""
    @Published var dietaryPreferences: String = ""

    // Selected index properties (if applicable)
    @Published var selectedGenderIndex: Int = 0 // Update type to Int
    @Published var selectedGoalIndex: Int = 0 // Update type to Int
    @Published var selectedActivityLvlIndex: Int = 0 // Update type to Int

    // Function to update user data
    func updateUserData(weight: String, height: String, age: String, goal: String,
                        gender: String, activityLevel: String, dietaryPreferences: String,
                        selectedGenderIndex: Int, selectedGoalIndex: Int, selectedActivityLvlIndex: Int) {
        // Input validation and error handling (optional but recommended)
        if weight.isEmpty || height.isEmpty || age.isEmpty || goal.isEmpty || gender.isEmpty || activityLevel.isEmpty {
            print("Error: All fields must be filled.")
            return
        }

        // Update data properties
        self.weight = weight
        self.height = height
        self.age = age
        self.goal = goal
        self.gender = gender
        self.activityLevel = activityLevel
        self.dietaryPreferences = dietaryPreferences

        // Update selected indices
        self.selectedGenderIndex = selectedGenderIndex
        self.selectedGoalIndex = selectedGoalIndex
        self.selectedActivityLvlIndex = selectedActivityLvlIndex

        // Persist data to storage (optional, see comments below)
        // ... (add persistence implementation here)

        // Trigger data changes notification
        
        print("done update user data")
        objectWillChange.send()
    }
}


struct UserInputs: View {
    
    
//    @State var weight: String
//    @State var height: String
//    @State var age: String
//    @State var goal: String
//    @State var gender: String
//    @State var activityLevel: String
//    @State var dietaryPreferences: String
//    @State private var selectedGenderIndex = 0
//    @State private var selectedGoalIndex = 0
//    @State private var selectedActivityLvlIndex = 0
    
    @EnvironmentObject var userData: UserData
    @StateObject private var authManager = AuthenticationManager.shared

    
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
        
        userData.updateUserData(weight: userData.weight, height: userData.height, age: userData.age, goal: userData.goal, gender: userData.gender, activityLevel: userData.activityLevel, dietaryPreferences: "dietatry update", selectedGenderIndex: userData.selectedGenderIndex, selectedGoalIndex: userData.selectedGoalIndex, selectedActivityLvlIndex: userData.selectedActivityLvlIndex)

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

            VStack(alignment: .leading,spacing: 30, content: {
                HStack( content: {
                    Text("Age:")
                    TextField("Age", text: $userData.age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 210)
                        .padding(.leading)
                    Text("years old")
                        .foregroundColor(.secondary)
                
                })
                
                HStack(content: {
                    Text("Gender:")
                    Picker("Gender", selection: $userData.selectedGenderIndex) {
                        ForEach(0..<3) { index in
                            Text(genders[index])
                        }
                    }
                })
                
                HStack( content: {
                    Text("Weight:")
                    TextField("Weight", text: $userData.weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                    Text("lbs")
                        .foregroundColor(.secondary)
                })
                
                HStack(content: {
                    Text("Height: ")
                    TextField("Height", text: $userData.height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                    Text("ft")
                        .foregroundColor(.secondary)
                })
                        
                
                
                HStack(content: {
                    Text("Goal:")
                    Section {
                        Picker("Goals", selection: $userData.selectedGoalIndex) {
                            ForEach(0..<3) { index in
                                Text(goals[index])
                            }
                        }
                    }
                })
                
                HStack(content: {
                    Text("Activity Level:")

                    Section {
                        Picker("Activity Levels", selection: $userData.selectedActivityLvlIndex) {
                            ForEach(0..<3) { index in
                                Text(activityLevels[index])
                            }
                        }
                    }
                })
            })
            .padding()

            

            Button(action: {
                authManager.fakeLogin()
                saveProfile()
            }) {
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
    UserInputs()
}
