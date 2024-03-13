//
//  ExerciseService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 3/12/24.
//

import Foundation

struct ExerciseActivity: Codable, Identifiable {
    let id = UUID()
    let calories_burned: Double
    let instructions: String
    let length: String
    let title: String
}

@MainActor
class ExerciseService: ObservableObject {
    @Published var exerciseData: [String: [ExerciseActivity]] = [:]
    @Published var score: Double = 0
    @Published var exerciseScorePercentage: Double = 0
    @Published var todayExercise: Int = 0
    
    func fetchExerciseRecommendation(idToken: String?) async throws {
      print("calling fetchExercise")
        
        guard let idToken = idToken else {
          throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
        }

      // Replace with your actual API endpoint URL
      var urlComponents = URLComponents(string: baseURL + "/get_exercise")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "idToken", value: idToken),
        ]

      let url = urlComponents.url!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: request)
          
      

        // Check for successful response
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }

      let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [[String: Any]]]

        print("hello jsonresponse from exercise")
        
        print(jsonResponse)
        
        var exerciseData2: [String: [ExerciseActivity]] = [:]
        
        let listDate = ["day_1", "day_2", "day_3", "day_4", "day_5", "day_6", "day_7"]
        
        for dateString in listDate{
            if let exercisesDay1 = jsonResponse![dateString]{
                var listDay1: [ExerciseActivity] = []
                for exercise in exercisesDay1{
                    
                    let caloriesBurned = exercise["calories_burned"] as! Double
                    var instruction = exercise["instruction"]
                    if (instruction == nil){
                        instruction = exercise["instructions"]
                    }
                    let length = exercise["length"]
                    let title = exercise["title"]
                    
                    let newExercise = ExerciseActivity(calories_burned: caloriesBurned, instructions: instruction as! String, length: length as! String, title: title as! String)
                    
                    listDay1.append(newExercise)
                }
                
                exerciseData2[dateString] = listDay1
            }
        }

        await DispatchQueue.main.async {
            self.exerciseData = exerciseData2
        }
    }
    
    
    func fetchExerciseScore(idToken: String?) async throws {
        print("calling fetchExerciseScore")
          
          guard let idToken = idToken else {
            throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
          }

        // Replace with your actual API endpoint URL
        var urlComponents = URLComponents(string: baseURL + "/get_exercise_score")!
          
          urlComponents.queryItems = [
              URLQueryItem(name: "idToken", value: idToken),
          ]

        let url = urlComponents.url!

          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")


          // Perform the network request
          let (data, response) = try await URLSession.shared.data(for: request)
            
        

          // Check for successful response
          guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
          }

        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Double]
        
        let score = jsonResponse!["exercise_score"]
        
        await DispatchQueue.main.async {
            self.score = score!
            self.exerciseScorePercentage = score! / 10
        }
        
    }
    
    
    func fetchExerciseDay(idToken: String?) async throws {
        print("calling fetchExerciseScore")
          
          guard let idToken = idToken else {
            throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
          }

        // Replace with your actual API endpoint URL
        var urlComponents = URLComponents(string: baseURL + "/get_exercise_day")!
          
          urlComponents.queryItems = [
              URLQueryItem(name: "idToken", value: idToken),
          ]

        let url = urlComponents.url!

          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")


          // Perform the network request
          let (data, response) = try await URLSession.shared.data(for: request)
            
        

          // Check for successful response
          guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
          }

        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Int]
        
        let day = jsonResponse!["exercise_day"]
        
        await DispatchQueue.main.async {
            self.todayExercise = day!
        }
        
    }
    
    
    
}
