//
//  WellnessHub_AppApp.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI


let baseURL = "https://cs125-w24-flask-api.uw.r.appspot.com"


@main
struct WellnessHub_AppApp: App {

    @StateObject private var healthKitManager = HealthkitManager()
    @StateObject private var dietService = DietService()
    @StateObject private var sleepService = SleepService()
    @StateObject private var userData = UserData()
    @StateObject private var exerciseService = ExerciseService()
    @StateObject private var loginSignUpService = LoginSignupService()
    
    
//    @StateObject private var dietService = DietService()
//    @StateObject private var userData = UserData(healthKitManager: healthKitManager)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
                .environmentObject(dietService)
                .environmentObject(healthKitManager)
                .environmentObject(sleepService)
                .environmentObject(exerciseService)
                .environmentObject(loginSignUpService)
        }
    }
}
