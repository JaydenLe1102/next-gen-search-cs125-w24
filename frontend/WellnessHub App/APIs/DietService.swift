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


class DietService: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
    
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
}
