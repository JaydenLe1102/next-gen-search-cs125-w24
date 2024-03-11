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
    
    private var authManager = AuthenticationManager.shared
    var healthKitManager: HealthkitManager
    var formatter: DateFormatter
    
    //UserInfo
    @Published var email: String = ""
    @Published var fullname: String = ""
    @Published var last_update_weight:String = ""
    

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
    
    init(healthKitManager: HealthkitManager){
        self.healthKitManager = healthKitManager
        self.formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

    }
    
    func get_last_update_weight_date() -> Date?{
        print("lst update weight")
        print(self.last_update_weight)
        return formatter.date(from: self.last_update_weight) ?? nil
    }
    
    func getUpdateInfoForApi() -> [String:Any]{
        
        print("getUpdateInfoForApi: ")
        print(self.healthKitManager.calories_burn_yesterday)
        let param: [String:Any] = [
            "idToken": authManager.authToken,
            "activity_level": self.activityLevel,
            "age": Int(self.age) ?? "",
            "calories_burn_yesterday": self.healthKitManager.calories_burn_yesterday,
            "dietary_preference":  self.healthKitManager.sleep_time_yesterday,
            "email": self.email,
            "full_name": self.fullname,
            "gender": self.gender,
            "health_goal": self.goal,
            "height": self.height,
            "weight": self.weight,
            "sleep_time_yesterday": self.healthKitManager.sleep_time_yesterday,
            "last_update_weight": self.last_update_weight
        ]
        
        return param
    }
    
    func updateUserInfo(param: [String:Any], completion: @escaping (Result<Void, Error>) -> Void) {
      let urlString = "http://127.0.0.1:5000/userinfo"
      guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
        return
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = "PATCH"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      let jsonData = try? JSONSerialization.data(withJSONObject: param)
      
      guard let data = jsonData else {
        completion(.failure(NSError(domain: "JSONEncodingError", code: -2, userInfo: nil)))
        return
      }
      
      request.httpBody = data
      
      let session = URLSession.shared
      let task = session.dataTask(with: request) { data, response, error in
        guard let _ = data, error == nil else {
          completion(.failure(error ?? NSError(domain: "UnknownError", code: -1, userInfo: nil)))
          return
        }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
          completion(.success(()))
        } else {
          completion(.failure(NSError(domain: "APIError", code: -3, userInfo: nil)))
        }
      }
      
      task.resume()
    }


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
//        self.last_update_weight = formatter.string(from: Date())

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
        
        let param = self.getUpdateInfoForApi()
        
        print("update info param")
        print(param)
        
        self.updateUserInfo(param: param){result in
            switch result {
            case .success:
                print("User information updated successfully!")
            case .failure(let error):
                print("Error updating user info: \(error.localizedDescription)")
            }
            
        }
       
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
                self.email = dataExtracted["email"] as! String
                self.last_update_weight = dataExtracted["last_update_weight"] as! String
                self.saveProfile()
            }
        }
        catch{
            print("Error fetching data: ", error)
        }
        
    }
    
    private func fetchProfileInfo(idToken: String?) async throws -> [String:Any] {
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
