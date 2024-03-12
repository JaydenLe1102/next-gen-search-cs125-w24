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

let baseURL = "http://127.0.0.1:5000"

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
            print("hello world")
            print(recipeDictionary["Calories"])
            
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


//    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        
//        print("calling fetchrecipe")
//        // Replace with your actual API endpoint URL
        
//        var urlComponents = URLComponents(string: baseURL + "/get_recipes")!

//        urlComponents.queryItems = [
//            URLQueryItem(name: "minCalories", value: "100"),
//            URLQueryItem(name: "maxCalories", value: "600")
//        ]

        
//        let url = urlComponents.url!

//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"

//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

//        var recipes: [Recipe] = []
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "NetworkError", code: -1, userInfo: nil)))
//                return
//            }
            


//                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                    do {
//                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                        
////                        print(jsonResponse)
//                            // Access the results array here
//                        if let recipesArray = jsonResponse { // Unwrap the optional
////                            print("hello")
////                            print(recipesArray)
//                            for recipeDictionary in recipesArray { // Now you can iterate through the array
//                                let imageUrl = recipeDictionary["imageUrl"] as? String // "https://spoonacular.com/recipeImages/782585-312x231.jpg"
//                                let calories = recipeDictionary["calories"] as? String // "482.18 kcal"
//                                let title = recipeDictionary["title"] as? String // "Cannellini Bean and Asparagus Salad with Mushrooms"
//                                let id = recipeDictionary["id"] as? Int // "782585"

//                                // Use the extracted values here
////                                print("Image URL:", imageUrl!)
////                                print("Calories:", calories!)
////                                print("Title:", title!)
////                                print("ID:", id!)
                                
//                                //recipes.append(Recipe(id: id!, image: imageUrl!, calories: calories!, title: title!))
//                                recipes.append(Recipe(id: id!, image: imageUrl!, calories: calories!, title: title!))
                                
//                            }
                            
//                            print("done extract")
                            
//                        } else {
//                            print("Error: No recipes received")
//                        }
             
//                    completion(.success(recipes))
//                } catch {
//                    completion(.failure(error))
//                }
//            } else {
//                completion(.failure(NSError(domain: "LoginError", code: -1, userInfo: nil)))
//            }
//        }.resume()
//    }
}
