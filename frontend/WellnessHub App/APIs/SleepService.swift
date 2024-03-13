//
//  SleepService.swift
//  WellnessHub App
//
//  Created by JetnutShark on 3/12/24.
//

import Foundation
@MainActor
class SleepService: ObservableObject {
    
    @Published var sleepRec: [Int] = []
    @Published var sleepPoint: Double = 0
    @Published var sleepProgressPercentage: Double = 0
    @Published var sleepMessageRecommendation: String = ""
    
    let maxPointPerWeek:Double = 10
    
    func fetch_sleep_rec_point(idToken: String?) async throws {
        try await self.fetchSleepRec(idToken: idToken)
        try await self.fetchSleepPoint(idToken: idToken)
    }
    
    
    private func fetchSleepRec(idToken: String?) async throws {
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

        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [Int]
        
        print("hello sleep response")
        print(jsonResponse)
        
        await DispatchQueue.main.async {
            self.sleepRec = jsonResponse ?? []
            self.sleepMessageRecommendation = "Aim for \(self.sleepRec[0])-\(self.sleepRec[self.sleepRec.endIndex - 1]) hours of sleep each night for optimal health."
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
