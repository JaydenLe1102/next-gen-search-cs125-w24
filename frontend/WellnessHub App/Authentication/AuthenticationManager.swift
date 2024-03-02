//
//  AuthenticationManager.swift
//  WellnessHub App
//
//  Created by JetnutShark on 2/21/24.
//

import Foundation

@MainActor
class AuthenticationManager: ObservableObject {
    static let shared = AuthenticationManager()
    
    private let userDefaults = UserDefaults.standard
    private let authTokenKey = "AuthToken"
    
    @Published var isAuthenticated = false
    
    var authToken: String? {
        return userDefaults.string(forKey: authTokenKey)
    }
    
//    @Published
    func login(withToken token: String, userId: String) {
        
        isAuthenticated = true

        // Store the authentication token securely
        userDefaults.set(token, forKey: authTokenKey)
        userDefaults.set(userId, forKey: userId)
    }
    
    func logout() {
        isAuthenticated = false
        // Remove the stored authentication token
        userDefaults.removeObject(forKey: authTokenKey)
    }
    
    func fakeLogin(){
        isAuthenticated = true
    }
}

// Usage:
// Login
//let authToken = "example_auth_token"
//AuthenticationManager.shared.login(withToken: authToken)
//
//// Check authentication status
//if AuthenticationManager.shared.isAuthenticated {
//    print("User is logged in")
//} else {
//    print("User is not logged in")
//}
//
//// Logout
//AuthenticationManager.shared.logout()
