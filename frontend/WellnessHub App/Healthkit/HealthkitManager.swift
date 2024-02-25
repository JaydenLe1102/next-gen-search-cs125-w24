//
//  HealthDataManager.swift
//  WellnessHub App
//
//  Created by JetnutShark on 2/7/24.
//

import Foundation
import HealthKit

extension Date{
    static var startOf7PreviousDay: Date{
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return Calendar.current.startOfDay(for: sevenDaysAgo)
    }
    static var startOfYesterday: Date{
        let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        return Calendar.current.startOfDay(for: oneDayAgo)
    }
}

class HealthkitManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    init(){
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let bodyMassType = HKObjectType.quantityType(forIdentifier: .bodyMass)!
        let bodyFatPercentageType = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)!
        
        let healthTypes:Set = [steps, calories, bodyMassType, bodyFatPercentageType]
        
        Task{
            do{
                guard HKHealthStore.isHealthDataAvailable() else {
                    // HealthKit is not available on this device
                    print("HealthKit is not available on this device")
                    return
                }
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            }catch{
                print("error fetching data")
            }
        }
    }
    
    func testRun(){
        print("hello world")
    }
    
    func fetchBodyMass() {
        guard let bodyMassType = HKObjectType.quantityType(forIdentifier: .bodyMass) else {
            print("Body mass data is not available.")
            return
        }
        
        
        let predicate = HKQuery.predicateForSamples(withStart: .startOf7PreviousDay, end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: bodyMassType, quantitySamplePredicate: predicate) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                print("Failed to fetch body mass data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let bodyMass = sum.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            print("Body mass: \(bodyMass) kg")
        }
        
        healthStore.execute(query)
    }
    
    func fetchSteps(){
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOf7PreviousDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate){ _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else{
                print("error fetching steps")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            print("Step count for today: ")
            print(stepCount)
        }
        
        healthStore.execute(query)
    }
    
    func fetchCalories(){
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOf7PreviousDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate){ _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else{
                print("error fetching calories")
                return
            }
            let caloriesBurn = quantity.doubleValue(for: .kilocalorie())
            print("Calories Burn for today: ")
            print(caloriesBurn)
        }
        
        healthStore.execute(query)
    }
    
    func fetchAndSendHealthDataToServer() {
        // Check if HealthKit is available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            // HealthKit is not available on this device
            print("HealthKit is not available on this device")
            return
        }
        
        // Request authorization to read step count data
        healthStore.requestAuthorization(toShare: nil, read: [HKObjectType.quantityType(forIdentifier: .stepCount)!]) { (success, error) in
            guard success else {
                // Authorization failed, handle the error
                if let error = error {
                    print("Authorization failed: \(error.localizedDescription)")
                }
                return
            }
            
            // Authorization succeeded, fetch step count data for the past seven days
            for i in 0..<7 {
                guard let previousDate = Calendar.current.date(byAdding: .day, value: -i, to: Date()) else {
                    // Error calculating previous date
                    return
                }
                
                print(self.fetchStepCount(for: previousDate))
                print("done fetch step count")
                
            }
        }
    }
    
    private func fetchStepCount(for date: Date) {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            guard let result = result, let sum = result.sumQuantity() else {
                // Handle the error
                return
            }
            
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            print("Steps for \(date): \(steps)")
            
            // Call API to update user profile with step count data
            self.updateUserProfileWithHealthData(date: date, steps: steps)
        }
        
        return healthStore.execute(query)
    }
    

    
    private func updateUserProfileWithHealthData(date: Date, steps: Int) {
        // Here, you would make an API call to update the user profile with the retrieved health data
        // You can use URLSession or any networking library of your choice to make the API call
        let urlString = "https://yourapi.com/updateUserProfile"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "date": date,
            "steps": steps
            // Add other health data as needed
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error encoding parameters: \(error)")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating user profile: \(error)")
                return
            }
            
            // Handle response from server if needed
        }
        
        task.resume()
    }
}

//// Usage
//let healthDataManager = HealthDataManager()
//healthDataManager.fetchAndSendHealthDataToServer()
