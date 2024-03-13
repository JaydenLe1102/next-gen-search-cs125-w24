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
    private let authTokenKey: String = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjYwOWY4ZTMzN2ZjNzg1NTE0ZTExMGM2ZDg0N2Y0M2M3NDM1M2U0YWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY3MxMjUtcHJvamVjdC1iNmVhNSIsImF1ZCI6ImNzMTI1LXByb2plY3QtYjZlYTUiLCJhdXRoX3RpbWUiOjE3MTAyNTYwNzcsInVzZXJfaWQiOiJsbjhQbndsaEZlU2dPTGZxdzhnaGdHZExVTzIzIiwic3ViIjoibG44UG53bGhGZVNnT0xmcXc4Z2hnR2RMVU8yMyIsImlhdCI6MTcxMDI1NjA3NywiZXhwIjoxNzEwMjU5Njc3LCJlbWFpbCI6InRlc3RAZW1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInRlc3RAZW1haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.UEWIOz8XZqmJ57IXwb2gAPH5UJ0QjfZJLnc_lr54dljG9DwayzLGVV2RgmQjcOJMuZ3-XCZRpTv5YLDybUi6930NfOc8GSmlBznYWvC9Hmsrz1IGIGLnfwXdVQlGYF24yS3YpvJu2Gmrh0GEMjq97j9Uk9Q7IUetSHkaHRZA8q-7EVdyKMY9J39PWsHsubLyNp9b7WI5sEI95YcVwYy2TMo9Trg-7Z7Y0oGCjNO4NGdqVBirJ6DmLsmhENUMczyrtz_3NLVIRGa44m0H7ow35UTpcQ4LYe6KzpNXCquyRXCShke0zDoLrhkSw8IbOdVBc-ucOY59LCqfOFCXNgPujQ" // hard coded for now
    
    private var isSignedUp = false
    
    @Published var isAuthenticated = false
    
    var authToken: String? {
        return UserDefaults.standard.string(forKey: authTokenKey)
    }
    
    
//    @Published
    func login(withToken token: String, userId: String) {
        
        isAuthenticated = true

        if (isSignedUp == false){
            // Store the authentication token securely
            userDefaults.set(token, forKey: authTokenKey)
            userDefaults.set(userId, forKey: userId)
        }

    }
    
    func login() {
        
        if (isSignedUp == true){
            isAuthenticated = true
        }

    }
    
    func signUp(withToken token: String, userId: String){
        userDefaults.set(token, forKey: authTokenKey)
        userDefaults.set(userId, forKey: userId)
        isSignedUp = true
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
