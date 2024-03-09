//
//  ProfileService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 3/4/24.
//

import Foundation

@MainActor
class UserData: ObservableObject {
    
    static let genders = ["Male", "Female", "Other"]
    static let  goals = ["Lose weight", "Gain weight", "Remain weight"]
    static let activityLevels = ["Beginner", "Intermediate", "Professional"]

    // User data properties
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var age: String = ""
    @Published var goal: String = ""
    @Published var gender: String = ""
    @Published var activityLevel: String = ""
    @Published var dietaryPreferences: String = ""

    // Selected index properties (if applicable)
    @Published var selectedGenderIndex: Int = 0 // Update type to Int
    @Published var selectedGoalIndex: Int = 0 // Update type to Int
    @Published var selectedActivityLvlIndex: Int = 0 // Update type to Int

    // Function to update user data
    func saveProfile() {

        // Update data properties
        self.weight = self.weight.trimmingCharacters(in: .whitespacesAndNewlines)
        self.height = self.height.trimmingCharacters(in: .whitespacesAndNewlines)
        self.age = self.age.trimmingCharacters(in: .whitespacesAndNewlines)
        self.goal = UserData.goals[self.selectedGoalIndex]
        self.gender = UserData.genders[self.selectedGenderIndex]
        self.activityLevel = UserData.activityLevels[self.selectedActivityLvlIndex]
        self.dietaryPreferences = self.dietaryPreferences.trimmingCharacters(in: .whitespacesAndNewlines)

        // Persist data to storage (optional, see comments below)
        // ... (add persistence implementation here)

        // Trigger data changes notification
                
        print("Printing hello world")
        print("Saved Profile:")
        print("Age: \(self.age)")
        print("Gender: \(self.gender)")
        print("Weight: \(self.weight) lbs")
        print("Height: \(self.height) ft")
        print("Goal: \(self.goal)")
        print("Activity Level: \(self.activityLevel)")
        
        print("done update user data")
        objectWillChange.send()
    }
    
    func fetch_and_update(idToken: String?) async throws{
        do{
            let dataExtracted = try await self.fetchProfileInfo(idToken: idToken)
            
            print("Received data:")
            print(dataExtracted)
            await DispatchQueue.main.async {

                self.height = (dataExtracted["height"] as AnyObject).description
                self.weight = (dataExtracted["weight"] as AnyObject).description
                self.dietaryPreferences = dataExtracted["dietary_preference"] as? String ?? ""
                self.age = (dataExtracted["age"] as AnyObject).description
                
                let gender1 = dataExtracted["gender"] as? String ?? ""
                for (index, gender) in UserData.genders.enumerated() {
                    if gender1.lowercased() == gender.lowercased() {
                        self.selectedGenderIndex = index
                        self.gender = UserData.genders[index]
                        break
                    }
                }
                
                
                let goal1 = dataExtracted["health_goal"] as? String ?? ""
                for (index, goal) in UserData.goals.enumerated() {
                    if goal1.lowercased() == goal.lowercased() {
                        self.selectedGoalIndex = index
                        self.goal = UserData.goals[index]
                        break
                    }
                }
                
                
                let activityLevel1 = dataExtracted["activity_level"] as? String ?? ""
                for (index, activityLevel) in UserData.activityLevels.enumerated() {
                    if activityLevel1.lowercased() == activityLevel.lowercased() {
                        self.selectedActivityLvlIndex = index
                        self.activityLevel = UserData.activityLevels[index]
                        break
                    }
                }
                self.saveProfile()
            }
        }
        catch{
            print("Error fetching data: ", error)
        }
        
    }
    
    private  func fetchProfileInfo(idToken: String?) async throws -> [String:Any] {
        print("calling fetch profile info")

        guard let idToken = idToken else {
          throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
        }
        
        var urlComponents = URLComponents(string: "http://127.0.0.1:5000/userinfo")!

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
        print(decodedData)
        
      // Extract the data you need (replace with your logic)
        if let dataExtracted = decodedData as? [String:Any] {
          print(dataExtracted)
        return dataExtracted
      } else {
        // Handle unexpected response format
        throw URLError(.cannotDecodeRawData)
      }
    }
    
}
