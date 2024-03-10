//
//  ContentView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var dietService: DietService
    
    @StateObject private var authManager = AuthenticationManager.shared
    
    //view properties
    @State private var showSignUp: Bool = false
//    @State private var showHome: Bool = false
//    @State private var isLoggedIn = authManager.isAuthenticated
    @State private var selectedTab = 1
    
    @State private var isLoggedIn = true
    
    @State private var isWeightModalPresented = false
    @State private var currentWeight = ""


    var body: some View {
        
        if authManager.isAuthenticated {
            
            TabView(selection: $selectedTab) {
                
                Home().tag(1)
                
                Diet(caloriesNum: 20).tag(2)
                
                Exercises().tag(3)

                Sleep().tag(4)
                    .navigationBarHidden(true)
                
                Profile().tag(5)
                    .navigationBarHidden(true)
                
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
            .overlay(alignment: .center, content: {
                CustomInputModal(isWeightModalPresented: $isWeightModalPresented, currentWeight: .constant("150"))
                    .opacity(isWeightModalPresented ? 0 : 1)
            })
            .onAppear {
                Task{

                    do {
                        try await userData.fetch_and_update(idToken: authManager.authToken )
                        try await dietService.fetchRecipesAsyncAwait()
                    } catch {
                        // Handle network errors
                        print("Error fetching data:", error)
                    }
                }
            }
            
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
        .environmentObject(UserData())
}
