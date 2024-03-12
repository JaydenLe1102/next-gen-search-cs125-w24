//
//  ProfileService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 3/4/24.
//

import Foundation



@MainActor
class UserData: ObservableObject {
    
    private let baseURL = "http://127.0.0.1:5000"
    
    static let genders = ["Male", "Female", "Other"]
    static let  goals = ["Lose weight", "Gain weight", "Remain weight"]
    static let activityLevels = ["Beginner", "Intermediate", "Professional"]
    
    private var authManager = AuthenticationManager.shared
    //    var healthKitManager: HealthkitManager
    //    var dietService: DietService
    //    var sleepService: SleepService
    var formatter: DateFormatter
    
    //UserInfo
    @Published var email: String = "N/A"
    @Published var fullname: String = "N/A"
    @Published var last_update_weight:String = "N/A"
    
    
    
    // User data properties
    @Published var weight: String = "N/A"
    @Published var height: String = "N/A"
    @Published var age: String = "N/A"
    @Published var goal: String = "N/A"
    @Published var gender: String = "N/A"
    @Published var activityLevel: String = ""
    @Published var dietaryPreferences: String = "N/A"
    @Published var target_weight: String = "N/A"
    
    @Published var day_score_percentage: Double = 0
    
    // Selected index properties (if applicable)
    @Published var selectedGenderIndex: Int = 0 // Update type to Int
    @Published var selectedGoalIndex: Int = 0 // Update type to Int
    @Published var selectedActivityLvlIndex: Int = 0 // Update type to Int
    
    init(){
        //        self.healthKitManager = healthKitManager
        //        self.dietService = dietService
        //        self.sleepService = sleepService
        self.formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
    }
    
    func get_last_update_weight_date() -> Date?{
        print("lst update weight")
        print(self.last_update_weight)
        return formatter.date(from: self.last_update_weight) ?? nil
    }
    
    func getUpdateInfoForApi() -> [String:Any]{
        
        let param: [String:Any] = [
            "idToken": authManager.authToken,
            "activity_level": self.activityLevel,
            "age": Int(self.age) ?? "",
            "dietary_preference":  self.dietaryPreferences,
            "email": self.email,
            "full_name": self.fullname,
            "gender": self.gender,
            "health_goal": self.goal,
            "height": self.height,
            "weight": self.weight,
            "last_update_weight": self.last_update_weight,
            "target_weight": self.target_weight,
            //            "calories_consumed": self.dietService.caloriesConsume,
            //            "caloriesIntakeRec": self.dietService.caloriesIntakeRec
        ]
        
        return param
    }
    
    func updateUserInfo(param: [String:Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = baseURL +  "/userinfo"
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
        self.target_weight = self.target_weight.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //        self.last_update_weight = formatter.string(from: Date())
        
        // Persist data to storage (optional, see comments below)
        // ... (add persistence implementation here)
        
        // Trigger data changes notification
        
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
                print("hello world updating user data please")
                self.height = dataExtracted["height"] as? String ?? ""
                self.weight = dataExtracted["weight"] as? String ?? ""
                self.dietaryPreferences = dataExtracted["dietary_preference"] as? String ?? ""
                self.age = (dataExtracted["age"] as AnyObject).description
                self.target_weight = (dataExtracted["target_weight"] as AnyObject).description
                //                self.dietService.caloriesConsume = Double((dataExtracted["calories_consumed"] as AnyObject).description)!
                //
                //                self.dietService.caloriesIntakeRec = Double((dataExtracted["caloriesIntakeRec"] as AnyObject).description)!
                
                
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
                
                //                self.saveProfile()
            }
        }
        catch{
            print("Error fetching data: ", error)
        }
        
    }
    
    
    func fetch_and_update2(idToken: String?, completion: @escaping (Error?) -> Void) {
        self.fetchProfileInfo2(idToken: idToken) { result in
            switch result {
            case .success(let dataExtracted):
                print("Received data:")
                print(dataExtracted)
                DispatchQueue.main.async {
                    print("hello world updating user data please")
                    self.height = dataExtracted["height"] as? String ?? ""
                    self.weight = dataExtracted["weight"] as? String ?? ""
                    self.dietaryPreferences = dataExtracted["dietary_preference"] as? String ?? ""
                    self.age = (dataExtracted["age"] as AnyObject).description
                    self.target_weight = (dataExtracted["target_weight"] as AnyObject).description
                    //            self.dietService.caloriesConsume = Double((dataExtracted["calories_consumed"] as AnyObject).description)!
                    //            self.dietService.caloriesIntakeRec = Double((dataExtracted["caloriesIntakeRec"] as AnyObject).description)!
                    
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
                    
                    print("before complete update userData")
                    print(self.getUpdateInfoForApi())
                    // Uncomment if you want to save the profile after update
                    self.saveProfile()
                    completion(nil)
                }
            case .failure(let error):
                print("Error fetching data:", error)
                completion(error)
            }
        }
    }
    
    
    private func fetchProfileInfo(idToken: String?) async throws -> [String:Any] {
        print("calling fetch profile info")
        
        guard let idToken = idToken else {
            throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
        }
        
        var urlComponents = URLComponents(string: baseURL + "/userinfo")!
        
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
        
        // Extract the data you need (replace with your logic)
        if let dataExtracted = decodedData as? [String:Any] {
            print(dataExtracted)
            return dataExtracted
        } else {
            // Handle unexpected response format
            throw URLError(.cannotDecodeRawData)
        }
    }
    
    private func fetchProfileInfo2(idToken: String?, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        print("calling fetch profile info2")
        
        guard let idToken = idToken else {
            completion(.failure(NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])))
            return
        }
        
        var urlComponents = URLComponents(string: baseURL + "/userinfo")!
        urlComponents.queryItems = [
            URLQueryItem(name: "idToken", value: idToken),
        ]
        
        let url = urlComponents.url!
        
        // Create the request
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
                let decodedData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                completion(.success(decodedData ?? [:]))
            } catch {
                completion(.failure(URLError(.cannotDecodeRawData)))
            }
        }.resume()
    }
    
    func getScoreForDay(idToken: String?) async throws{
        guard let idToken = idToken else {
            throw  NSError(domain: "MyErrorDomain", code: 1, userInfo: ["message": "Missing idToken"])
        }
        
        var urlComponents = URLComponents(string: baseURL + "/get_day_score")!
        
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
        let decodedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Double]
        
        let day_score = decodedData!["day_score"]
        
        DispatchQueue.main.async {
            self.day_score_percentage = day_score! / 30
        }
        
    }
    
}
