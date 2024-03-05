////
////  UserData.swift
////  WellnessHub App
////
////  Created by BobaHolic on 3/2/24.
////
//
//import SwiftUI
//
//class UserData: ObservableObject {
//    @Published var weight: String
//    @Published var height: String
//    @Published var age: String
//    @Published var goal: String
//    @Published var gender: String
//    @Published var activityLevel: String
//    @Published var dietaryPreferences: String
//    
//    @Published var selectedGenderIndex = 0
//    @Published var selectedGoalIndex = 0
//    @Published var selectedActivityLvlIndex = 0
//    
//    // Initializer
//    init(weight: String, height: String, age: String, goal: String, gender: String, activityLevel: String, dietaryPreferences: String, selectedGenderIndex: Int, selectedGoalIndex: Int, selectedActivityLvlIndex: Int) {
//            self.weight = weight
//            self.height = height
//            self.age = age
//            self.goal = goal
//            self.gender = gender
//            self.activityLevel = activityLevel
//            self.dietaryPreferences = dietaryPreferences
//            self.selectedGenderIndex = selectedGenderIndex
//            self.selectedGoalIndex = selectedGoalIndex
//            self.selectedActivityLvlIndex = selectedActivityLvlIndex
//        }
//}
//
//
//import Foundation
//
//@MainActor
//class UserData: ObservableObject {
//    static let shared = UserData()
//
//    // User data properties
//    @Published var weight: String = ""
//    @Published var height: String = ""
//    @Published var age: String = ""
//    @Published var goal: String = ""
//    @Published var gender: String = ""
//    @Published var activityLevel: String = ""
//    @Published var dietaryPreferences: String = ""
//
//    // Selected index properties (if applicable)
//    @Published var selectedGenderIndex: Int = 0 // Update type to Int
//    @Published var selectedGoalIndex: Int = 0 // Update type to Int
//    @Published var selectedActivityLvlIndex: Int = 0 // Update type to Int
//
//    // Function to update user data
//    func updateUserData(weight: String, height: String, age: String, goal: String,
//                        gender: String, activityLevel: String, dietaryPreferences: String,
//                        selectedGenderIndex: Int, selectedGoalIndex: Int, selectedActivityLvlIndex: Int) {
//        // Input validation and error handling (optional but recommended)
//        if weight.isEmpty || height.isEmpty || age.isEmpty || goal.isEmpty || gender.isEmpty || activityLevel.isEmpty {
//            print("Error: All fields must be filled.")
//            return
//        }
//
//        // Update data properties
//        self.weight = weight
//        self.height = height
//        self.age = age
//        self.goal = goal
//        self.gender = gender
//        self.activityLevel = activityLevel
//        self.dietaryPreferences = dietaryPreferences
//
//        // Update selected indices
//        self.selectedGenderIndex = selectedGenderIndex
//        self.selectedGoalIndex = selectedGoalIndex
//        self.selectedActivityLvlIndex = selectedActivityLvlIndex
//
//        // Persist data to storage (optional, see comments below)
//        // ... (add persistence implementation here)
//
//        // Trigger data changes notification
//        
//        print("done update user data")
//        objectWillChange.send()
//    }
//}
