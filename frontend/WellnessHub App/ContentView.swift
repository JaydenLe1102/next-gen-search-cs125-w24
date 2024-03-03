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
//    @State private var showHome: Bool = false
//    @State private var isLoggedIn = authManager.isAuthenticated
    @State private var selectedTab = 1
    
    @State private var isLoggedIn = true

    
    


    var body: some View {
        
        if authManager.isAuthenticated {
            
            TabView(selection: $selectedTab) {
                UserInputs().tag(0)
                
                Home().tag(1)
                
                Diet().tag(2)
                
                Exercises().tag(3)

                Sleep().tag(4)
                
                Profile().tag(5)
            }
            .overlay(alignment: .bottom, content: {
                CustomTabView(selectedTab: $selectedTab)
                    .background(.white)
                    .overlay(
                                Rectangle()
                                    .frame(height: 0.35)
                                    .foregroundColor(.gray)
                                    .offset(y: -39)
                                    .edgesIgnoringSafeArea(.top)
                            )
            })
        }
        else {
            NavigationStack {
                LogIn(showSignUp: $showSignUp, selectedTab: $selectedTab)
                    .navigationDestination(isPresented: $showSignUp) {
                        SignUp(showSignUp: $showSignUp, selectedTab: $selectedTab)
                    }
            }
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    ContentView()
}
