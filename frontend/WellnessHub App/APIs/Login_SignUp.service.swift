//
//  Login_SignUp.service.swift
//  WellnessHub App
//
//  Created by JetnutShark on 2/21/24.
//

import Foundation

@MainActor
class LoginSignupService: ObservableObject {
    static let shared = LoginSignupService()
    
    private let authManager = AuthenticationManager.shared
    
    
    func login(email: String, password: String, completion: @escaping (Result<(idToken: String, userID: String), Error>) -> Void) {
        let loginURL = URL(string: "\(baseURL)/login")!
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        print("email: " + email)
        print("password: " + password)
        print("login url:")
        print(loginURL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "UnknownError", code: -1, userInfo: nil)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    guard let idToken = jsonResponse?["idToken"] as? String,
                          let userID = jsonResponse?["userID"] as? String 
                    else {
                        completion(.failure(NSError(domain: "ParsingError", code: -1, userInfo: nil)))
                        return
                    }
                    
                    completion(.success((idToken: idToken, userID: userID)))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "LoginError", code: -1, userInfo: nil)))
            }
        }
        
        task.resume()
    }

    
    func signup(email: String, password: String, completion: @escaping (Result<(idToken: String, userID: String), Error>) -> Void) {
        let loginURL = URL(string: "\(baseURL)/signup")!
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        print("email: " + email)
        print("password: " + password)
        print("login url:")
        print(loginURL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "UnknownError", code: -1, userInfo: nil)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    print("sign up response")
                    print(jsonResponse)
                    
                    guard let idToken = jsonResponse?["idToken"] as? String,
                          let userID = jsonResponse?["userID"] as? String
                    else {
                        completion(.failure(NSError(domain: "ParsingError", code: -1, userInfo: nil)))
                        return
                    }
                    
                    completion(.success((idToken: idToken, userID: userID)))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "LoginError", code: -1, userInfo: nil)))
            }
        }
        
        task.resume()
    }

    
    

}

