//
//  SleepService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 3/12/24.
//

import Foundation
@MainActor
class SleepService: ObservableObject {
    
    @Published var sleepRecRange: [Int] = []
    @Published var sleepRecHour: Int = 0
    @Published var sleepPoint: Double = 0
    @Published var sleepProgressPercentage: Double = 0
    @Published var sleepMessageRecommendation: String = ""
    @Published var sleepMessageRecommendation2: String = ""
    
    
    let maxPointPerWeek:Double = 10
    
    func resetSleepService() async {
      await DispatchQueue.main.async {
        self.sleepRecRange = []
        self.sleepRecHour = 0
        self.sleepPoint = 0
        self.sleepProgressPercentage = 0
        self.sleepMessageRecommendation = ""
        self.sleepMessageRecommendation2 = ""
      }
    }
    
    func fetch_sleep_rec_point(idToken: String?, sleep_time_yesterday: Double) async throws {
        try await self.fetchSleepRec(idToken: idToken, sleep_time_yesterday: sleep_time_yesterday)
        try await self.fetchSleepPoint(idToken: idToken)
        
    }
    
    
    private func fetchSleepRec(idToken: String?, sleep_time_yesterday: Double) async throws {
        var urlComponents = URLComponents(string: baseURL + "/get_sleep")!
          
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

        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        
        print("hello sleep response")
        print(jsonResponse)
        
        let range = jsonResponse!["sleep_recommendation_range"]
        let hour = jsonResponse!["sleep_recommendation_hour"]
        
        await DispatchQueue.main.async {
            self.sleepRecRange = range as! [Int]
            self.sleepRecHour = hour as! Int
            
            self.sleepMessageRecommendation = "Aim for \(self.sleepRecRange[0])-\(self.sleepRecRange[self.sleepRecRange.endIndex - 1]) hours of sleep each night for optimal health."
            if (sleep_time_yesterday < hour as! Double * 3600){
                self.sleepMessageRecommendation2 = "You are not sleep enough. Please sleep more"
            }
            else{
                self.sleepMessageRecommendation2 = "You are sleeping enough. Good job!"
            }
        }
    }
    
    private func fetchSleepPoint(idToken: String?) async throws {
        var urlComponents = URLComponents(string: baseURL + "/get_sleep_point")!
          
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

        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Double]
        
        await DispatchQueue.main.async {
            self.sleepPoint = (jsonResponse?["sleep_point"])!
            self.sleepProgressPercentage = self.sleepPoint / self.maxPointPerWeek
        }
    }
    
    
    
}
