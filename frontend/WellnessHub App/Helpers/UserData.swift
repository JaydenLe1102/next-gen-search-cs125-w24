//
//  UserData.swift
//  WellnessHub App
//
//  Created by BobaHolic on 3/2/24.
//

import SwiftUI

class UserData: ObservableObject {
    @Published var weight: String
    @Published var height: String
    @Published var age: String
    @Published var goal: String
    @Published var gender: String
    @Published var activityLevel: String
    @Published var dietaryPreferences: String
    
    @Published var selectedGenderIndex = 0
    @Published var selectedGoalIndex = 0
    @Published var selectedActivityLvlIndex = 0
    
    // Initializer
    init(weight: String, height: String, age: String, goal: String, gender: String, activityLevel: String, dietaryPreferences: String, selectedGenderIndex: Int, selectedGoalIndex: Int, selectedActivityLvlIndex: Int) {
            self.weight = weight
            self.height = height
            self.age = age
            self.goal = goal
            self.gender = gender
            self.activityLevel = activityLevel
            self.dietaryPreferences = dietaryPreferences
            self.selectedGenderIndex = selectedGenderIndex
            self.selectedGoalIndex = selectedGoalIndex
            self.selectedActivityLvlIndex = selectedActivityLvlIndex
        }
}


