//
//  DietService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 2/23/24.
//

import Foundation

struct Recipe: Identifiable{
    let id: Int
    let image: String
    let calories: String
    let title: String
}

class DietService: ObservableObject {

    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        
        print("calling fetchrecipe")
        // Replace with your actual API endpoint URL
        
        var urlComponents = URLComponents(string: "http://127.0.0.1:5000/get_recipes")!

        urlComponents.queryItems = [
            URLQueryItem(name: "minCalories", value: "100"),
            URLQueryItem(name: "maxCalories", value: "600")
        ]

        
        let url = urlComponents.url!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        var recipes: [Recipe] = []
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NetworkError", code: -1, userInfo: nil)))
                return
            }
            


                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                        
//                        print(jsonResponse)
                            // Access the results array here
                        if let recipesArray = jsonResponse { // Unwrap the optional
//                            print("hello")
//                            print(recipesArray)
                            for recipeDictionary in recipesArray { // Now you can iterate through the array
                                let imageUrl = recipeDictionary["imageUrl"] as? String // "https://spoonacular.com/recipeImages/782585-312x231.jpg"
                                let calories = recipeDictionary["calories"] as? String // "482.18 kcal"
                                let title = recipeDictionary["title"] as? String // "Cannellini Bean and Asparagus Salad with Mushrooms"
                                let id = recipeDictionary["id"] as? Int // "782585"

                                // Use the extracted values here
//                                print("Image URL:", imageUrl!)
//                                print("Calories:", calories!)
//                                print("Title:", title!)
//                                print("ID:", id!)
                                
                                //recipes.append(Recipe(id: id!, image: imageUrl!, calories: calories!, title: title!))
                                recipes.append(Recipe(id: id!, image: imageUrl!, calories: calories!, title: title!))
                                
                            }
                            
                            print("done extract")
                            
                        } else {
                            print("Error: No recipes received")
                        }
             
                    completion(.success(recipes))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "LoginError", code: -1, userInfo: nil)))
            }
        }.resume()
    }
}
