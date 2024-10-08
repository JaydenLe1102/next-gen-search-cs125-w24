//
//  DietService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 2/23/24.
//

import Foundation

struct Recipe: Identifiable{
    var id: String
    
    let image: String
    let calories: Double
    let title: String
    let instruction: String
    let cookTime: String
    
}

@MainActor
class DietService: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var choosen_recipes: [Recipe] = []
    @Published var caloriesConsume: Double = 0
    @Published var dietScore:Double = 0
    @Published var dietProgressPercentage: Double = 0
    @Published var caloriesIntakeRec: Double = 0
    @Published var goalRecommendation: String = ""
    
    let maxPointPerWeek:Double = 10
    
    
    func resetDietService() async {
      await DispatchQueue.main.async {
        self.recipes = []
        self.choosen_recipes = []
        self.caloriesConsume = 0
        self.dietScore = 0
        self.dietProgressPercentage = 0
        self.caloriesIntakeRec = 0
      }
    }
    
    
    func fetchRecipesAsyncAwait(idToken: String?) async throws {
      print("calling fetchrecipe")
        
        guard let idToken = idToken else {
          throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
        }

      // Replace with your actual API endpoint URL
      var urlComponents = URLComponents(string: baseURL + "/get_diet")!
        
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

      let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]

      var recipes: [Recipe] = []

      if let recipesArray = jsonResponse {
        for recipeDictionary in recipesArray {
          let imageUrl = recipeDictionary["Images"] as? String
            
          let calories = recipeDictionary["Calories"] as? Double
          let title = recipeDictionary["Name"] as? String
            let instruction = recipeDictionary["RecipeInstructions"] as? String
            let cookTime = recipeDictionary["CookTime"] as? String

            recipes.append(Recipe(id: title!, image: imageUrl!, calories: calories!, title: title!, instruction: instruction!, cookTime: cookTime!))
        }
      } else {
        print("Error: No recipes received")
      }
    
        await DispatchQueue.main.async {
            self.recipes = recipes
        }
    }
    
    
    func addCaloriesConsume(calories:Double, idToken: String?){
        self.caloriesConsume += calories
        
        Task{
            try await self.getDietScore(idToken: idToken)
        }
    }
    
    func removeCaloriesConsume(calories:Double, idToken: String?){
        self.caloriesConsume -= calories
        
        Task{
            try await self.getDietScore(idToken: idToken)
        }
    }
    
    func getDietScore(idToken: String?) async throws {
        
        guard let idToken = idToken else {
          throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
        }

      // Replace with your actual API endpoint URL
      var urlComponents = URLComponents(string: baseURL + "/get_diet_score")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "idToken", value: idToken),
            URLQueryItem(name: "calories_consumed", value: String(self.caloriesConsume))
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
        
        let score = jsonResponse?["diet_score"]
        let calIntakeRec = jsonResponse?["caloriesIntakeRec"]
        let calConsumed = jsonResponse?["calories_consumed"]
        
        
        await DispatchQueue.main.async {
            self.dietScore = score!
            self.caloriesIntakeRec = calIntakeRec!
            self.caloriesConsume = calConsumed!
            self.dietProgressPercentage = self.dietScore / self.maxPointPerWeek
        }
    }
    
    func getDietScore2(idToken: String?, completion: @escaping (Result<Double, Error>) -> Void) {
      guard let idToken = idToken else {
        completion(.failure(NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])))
        return
      }

      // Replace with your actual API endpoint URL
      var urlComponents = URLComponents(string: baseURL + "/get_diet_score")!
      urlComponents.queryItems = [
        URLQueryItem(name: "idToken", value: idToken),
        URLQueryItem(name: "calories_consumed", value: String(self.caloriesConsume))
      ]

      let url = urlComponents.url!

      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      // Perform the network request
      URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          completion(.failure(error))
          return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          completion(.failure(URLError(.badServerResponse)))
          return
        }

        // Decode the JSON response
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Double]
          guard let score = jsonResponse?["diet_score"] else {
            completion(.failure(NSError(domain: "MyErrorDomain", code: 2, userInfo: ["message": "Missing 'diet_score' key in response"])))
            return
          }
          DispatchQueue.main.async {
            self.dietScore = score
            self.dietProgressPercentage = score / self.maxPointPerWeek
              
              
            completion(.success(score))
          }
          
        } catch {
          completion(.failure(error))
        }
      }.resume()
    }
    
    
    func fetchBmiRec(idToken: String?) async throws{
        guard let idToken = idToken else {
            throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
        }
        
        var urlComponents = URLComponents(string: baseURL + "/get_bmi_rec")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "idToken", value: idToken),
        ]
        
        let url = urlComponents.url!
        
        
        
        // Create the request
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
        
        
        // Decode the JSON response
        let decodedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        let calIntakeRec = decodedData!["caloriesIntakeRec"]
        let goalRec = decodedData!["Recommended Option"]
        
        DispatchQueue.main.async {
            self.caloriesIntakeRec = calIntakeRec as! Double
            self.goalRecommendation = goalRec as! String 
        }
    }

}
