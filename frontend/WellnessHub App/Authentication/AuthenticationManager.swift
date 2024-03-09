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
    private let authTokenKey: String = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjNiYjg3ZGNhM2JjYjY5ZDcyYjZjYmExYjU5YjMzY2M1MjI5N2NhOGQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY3MxMjUtcHJvamVjdC1iNmVhNSIsImF1ZCI6ImNzMTI1LXByb2plY3QtYjZlYTUiLCJhdXRoX3RpbWUiOjE3MDk2NjQ0OTEsInVzZXJfaWQiOiJsbjhQbndsaEZlU2dPTGZxdzhnaGdHZExVTzIzIiwic3ViIjoibG44UG53bGhGZVNnT0xmcXc4Z2hnR2RMVU8yMyIsImlhdCI6MTcwOTY2NDQ5MSwiZXhwIjoxNzA5NjY4MDkxLCJlbWFpbCI6InRlc3RAZW1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInRlc3RAZW1haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.GU9ruIADsONfbSAmkp3B4JtzaeQcEA8bf4-6Nneh2n1aEInoUoyxKvSgj1kShDkUel0oqQFVRVwbpybtmDP9-NmbupbRrw220cMmQU0wOb8JOOo3-zvtQ1mupEz7Wh6aOqmR1EI_m4EzamUiqjyZZjMnzQSwGi6pSGlcJ9w8EWhyQgAt7MgoIZGSjBFsDbOeCKt6rkJjLesFC0hr8MicXFJS28g8CIdiholoT4sRFaHLn4ogGJJimeZl1wNuSMe65a6JxapHH0eCkhykZ0Jpm7t_MkNxzItNnv5mCVttgpLRBDrtS-TBQhu5GeMAZtRcj4Auc2R-bAWWRnpgFN0srg" // hard coded for now
    
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
