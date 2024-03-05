//
//  ProfileService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 3/4/24.
//

import Foundation

class UserData: ObservableObject {
    
    static let genders = ["Male", "Female", "Other"]
    static let  goals = ["Lose weight", "Gain weight", "Remain weight"]
    static let activityLevels = ["Beginner", "Intermediate", "Professional"]

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
    func saveProfile() {

        // Update data properties
        self.weight = self.weight.trimmingCharacters(in: .whitespacesAndNewlines)
        self.height = self.height.trimmingCharacters(in: .whitespacesAndNewlines)
        self.age = self.age.trimmingCharacters(in: .whitespacesAndNewlines)
        self.goal = UserData.goals[self.selectedGoalIndex]
        self.gender = UserData.genders[self.selectedGenderIndex]
        self.activityLevel = UserData.activityLevels[self.selectedActivityLvlIndex]
        self.dietaryPreferences = self.dietaryPreferences.trimmingCharacters(in: .whitespacesAndNewlines)

        // Persist data to storage (optional, see comments below)
        // ... (add persistence implementation here)

        // Trigger data changes notification
                
        print("Printing hello world")
        print("Saved Profile:")
        print("Age: \(self.age)")
        print("Gender: \(self.gender)")
        print("Weight: \(self.weight) lbs")
        print("Height: \(self.height) ft")
        print("Goal: \(self.goal)")
        print("Activity Level: \(self.activityLevel)")
        
        print("done update user data")
        objectWillChange.send()
    }
    
}

class ProfileService: ObservableObject {
    
}
