//
//  ContentView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject private var authManager = AuthenticationManager.shared
    
    //view properties
    @State private var showSignUp: Bool = false
    @State private var showHome: Bool = false
    
    @State private var selectedTab = 1


    var body: some View {
        if authManager.isAuthenticated {
            MainTab(selectedTab: $selectedTab)
            
        }
        else {
            NavigationStack {
                LogIn(showSignUp: $showSignUp, showHome: $showHome, selectedTab: $selectedTab)
                    .navigationDestination(isPresented: $showSignUp) {
                        SignUp(showSignUp: $showSignUp)
                    }
            }
            .background(Color(.systemBackground))
        }
    }

}

#Preview {
    ContentView()
}
