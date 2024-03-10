//
//  WellnessHub_AppApp.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI

@main
struct WellnessHub_AppApp: App {

    @StateObject private var healthKitManager = HealthkitManager()
//    @StateObject private var dietService = DietService()
//    @StateObject private var userData = UserData(healthKitManager: healthKitManager)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData(healthKitManager: healthKitManager))
                .environmentObject(DietService())
                .environmentObject(healthKitManager)
        }
    }
}
