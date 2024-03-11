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
    private let authTokenKey: String = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjYwOWY4ZTMzN2ZjNzg1NTE0ZTExMGM2ZDg0N2Y0M2M3NDM1M2U0YWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY3MxMjUtcHJvamVjdC1iNmVhNSIsImF1ZCI6ImNzMTI1LXByb2plY3QtYjZlYTUiLCJhdXRoX3RpbWUiOjE3MTAwODA4MjIsInVzZXJfaWQiOiJsbjhQbndsaEZlU2dPTGZxdzhnaGdHZExVTzIzIiwic3ViIjoibG44UG53bGhGZVNnT0xmcXc4Z2hnR2RMVU8yMyIsImlhdCI6MTcxMDA4MDgyMiwiZXhwIjoxNzEwMDg0NDIyLCJlbWFpbCI6InRlc3RAZW1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInRlc3RAZW1haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.AEbPOkQjEFKnzpEGm8LLw_0uhUoO6z2Mh-7YJEc5rUoQDsBOo9SSMaGAnSc-CFBJ8yonUZAsMI1GoVTFZL9V8OoJbbdLDOsHivhnsOkxnMdioaM9V-kcNGSlRUuZ4WvBAJ5mphw1pc6JfVmPMmrGxdrJf_ROb1lmu8ZsU0flvVpoFpfuEfrIPxVYTXzwe45UABR9K_EpA1Zl-VppPcLT3Vq0waQSLIwKJnfLGUuQP4Cr_5D9JRHQ9jhamsyfVgcwncV3TfL0tKjANU79owjZDpyOLQUCI4f88KeGI5rFnQ8eMO6Ff7P6MN-VyQ8KV-gY90DLSqo2FjEX3WvaZuK5LQ" // hard coded for now
    
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
