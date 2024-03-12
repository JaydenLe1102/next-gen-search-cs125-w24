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
    private let authTokenKey: String = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjYwOWY4ZTMzN2ZjNzg1NTE0ZTExMGM2ZDg0N2Y0M2M3NDM1M2U0YWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY3MxMjUtcHJvamVjdC1iNmVhNSIsImF1ZCI6ImNzMTI1LXByb2plY3QtYjZlYTUiLCJhdXRoX3RpbWUiOjE3MTAyNDA0MDYsInVzZXJfaWQiOiJsbjhQbndsaEZlU2dPTGZxdzhnaGdHZExVTzIzIiwic3ViIjoibG44UG53bGhGZVNnT0xmcXc4Z2hnR2RMVU8yMyIsImlhdCI6MTcxMDI0MDQwNiwiZXhwIjoxNzEwMjQ0MDA2LCJlbWFpbCI6InRlc3RAZW1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInRlc3RAZW1haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.OALn96vu4Yw6kCYzl_4S261wQRGApQqJhDEQ9twnxVgITbH510jW-Es4Jbjp-oKD_e-fUtWeVhgOgcxNO7brFO5xlPseHXy2gIGgF7zfs0QPV74MrLTWZaa4gqSIUAQOwHOiIIzqmYzjq1-jbBryTszhpJ2MzeNIZwbuXBvPoUT0obguZ86JHsV4On_KqG81blNrbatjvMBDkdQ4gKAWzoynaFP8gxDxBRTlaanQaVYNuUCd9vJ0JDUxOimWgJaEW1Sh2Y06oSVGA42BPxQgcB2b5t5iU3q3ZXpSV_fl6NkxRjrfdt9XECF0U_vmfGvVoBg9b8ykYd3Q1a9cA8I2Ew" // hard coded for now
    
    @Published var isAuthenticated = false
    
    var authToken: String? {
        return authTokenKey
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
