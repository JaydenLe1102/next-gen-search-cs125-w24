//
//  WellnessHub_AppApp.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI


let baseURL = "http://127.0.0.1:5000"


@main
struct WellnessHub_AppApp: App {

    @StateObject private var healthKitManager = HealthkitManager()
    @StateObject private var dietService = DietService()
    @StateObject private var sleepService = SleepService()
    @StateObject private var userData = UserData()
    @StateObject private var exerciseService = ExerciseService()
    
    
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
        }
    }
}
