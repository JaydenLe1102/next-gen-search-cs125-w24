//
//  WellnessHub_AppApp.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI

@main
struct WellnessHub_AppApp: App {
    
    @AppStorage("lastRunDate") var lastRunDate: String = ""
    @StateObject var manager = HealthDataManager()
    
    init(){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        lastRunDate = dateFormatter.string(from: Date.distantPast)
//        
//        let healthDataManager = HealthDataManager()
//        healthDataManager.testRun()
//        healthDataManager.fetchAndSendHealthDataToServer()
        
    }
        
//    func runCodeOncePerDay() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let currentDate = Date()
//        
//        // Check if the stored date is not today
//        print("Code run everytime open app")
//        if !Calendar.current.isDate(dateFormatter.date(from: lastRunDate) ?? Date(), inSameDayAs: currentDate) {
//            // Execute your desired code here
//            print("Code is executed once per day")
//            
//            // Update the stored date to today
//            lastRunDate = dateFormatter.string(from: currentDate)
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}

