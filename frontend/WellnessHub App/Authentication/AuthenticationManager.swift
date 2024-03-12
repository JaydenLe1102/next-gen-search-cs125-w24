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
    private let authTokenKey: String = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjYwOWY4ZTMzN2ZjNzg1NTE0ZTExMGM2ZDg0N2Y0M2M3NDM1M2U0YWYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vY3MxMjUtcHJvamVjdC1iNmVhNSIsImF1ZCI6ImNzMTI1LXByb2plY3QtYjZlYTUiLCJhdXRoX3RpbWUiOjE3MTAyNDU5NTksInVzZXJfaWQiOiJsbjhQbndsaEZlU2dPTGZxdzhnaGdHZExVTzIzIiwic3ViIjoibG44UG53bGhGZVNnT0xmcXc4Z2hnR2RMVU8yMyIsImlhdCI6MTcxMDI0NTk1OSwiZXhwIjoxNzEwMjQ5NTU5LCJlbWFpbCI6InRlc3RAZW1haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInRlc3RAZW1haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.Llchqh4YWrvolosV9-2wK7-qy0ksrC2WOd4nNLkPbUF-xUt29rTi7fZV3IxMclJryMhINYbdoTdWznkviSIKUpgz0tCa_iffV_o1_bV5_vB-veEdoxuePKUt0AsTQkopTRUuWkKc0SDu9IX0Vgwhf8yr46q_StD94fQgpAiM9wPzKK5PvDMArIq1Eb4NeKwAohuh2tEgKQMy6O9XL6Krc0UaEvkM1FtGObqbPReh1z5ODl7NYGz8gQznzpVAuAYv6Dw_SYWNVNUEF4oweJo6hc_bsb2UFXOYlbGBThi9_QzcI9pEHIgjdWSv4gkiaJOvWs8Xxuw1tMOfpwBRRp9AMQ" // hard coded for now
    
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
