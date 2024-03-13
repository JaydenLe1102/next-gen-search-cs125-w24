

//
//  LogIn.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI

struct LogIn: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var dietService: DietService
    @EnvironmentObject var healthManager: HealthkitManager
    @EnvironmentObject var sleepService: SleepService
    @EnvironmentObject var exerciseService: ExerciseService
    
    
    @Binding var showSignUp: Bool
    @Binding var selectedTab: Int

    //view properties
    @State private var emailID: String = "test@email.com"
    @State private var password: String = "123456"
    @StateObject private var authManager = AuthenticationManager.shared
    @StateObject private var loginSignupService = LoginSignupService.shared
    @State private var isLoading = false
    


    var body: some View {
            VStack(alignment: .center, spacing:50, content: {
                
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .hSpacing()
                
                VStack(spacing: 25) {
                    CustomTextField(icon: "at", hint: "Email ID", value: $emailID)
                    
                    CustomTextField(icon: "lock", hint: "Password", isPassword: true, value: $password)
                        .padding(.top, 5)
                    
                    Button("Forgot Password?") {
                        
                    }
                    .font(.callout)
                    .fontWeight(.heavy)
                    .tint(.gray)
                    .hSpacing()
                    

                        
                    }
                
                Button(action: {
                    
                    loginSignupService.login(email: emailID, password: password) { result in
                                                switch result {
                                                case .success(let tokens):
                                                    print("Login successful. idToken: \(tokens.idToken), userID: \(tokens.userID)")
                
                                                    
                                                    Task{
                                                        isLoading = true
                                                        do{
                                                            try await userData.fetch_and_update(idToken: tokens.idToken)
                                                            try await dietService.getDietScore(idToken: tokens.idToken)
                                                            try await sleepService.fetch_sleep_rec_point(idToken: tokens.idToken)
                                                            
                                                            try await dietService.fetchRecipesAsyncAwait(idToken: tokens.idToken)
                                                            
                                                            try await userData.getScoreForDay(idToken: tokens.idToken)
                                                            
                                                            try await exerciseService.fetchExerciseRecommendation(idToken: tokens.idToken)
                                                            
                                                            try await exerciseService.fetchExerciseScore(idToken: tokens.idToken)
                                                        }
                                                        catch{
                                                            print("Failed to load initial data")
                                                        }
                                                        isLoading = false
                                                        
                                                        authManager.login(withToken: tokens.idToken, userId: tokens.userID)
                        
                                                        print("Login successful with checking token")
                                                        print(authManager.authToken)
                                                        
                                                        selectedTab = 1
                               
                                                    }
                                                   
                                                    
                                                case .failure(let error):
                                                    print("Login failed: \(error)")
                                                }
                                            }
                                            

                }) {
                    Text("Log in")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.teal)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                }
                
  
//                    disabling until the email and pw are entered
                .disableWithOpacity(emailID.isEmpty || password.isEmpty)
                .disabled(isLoading)
                
                ProgressView() // Display the loading spinner
                        .progressViewStyle(CircularProgressViewStyle())
                        .opacity(isLoading ? 1 : 0)
                
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                HStack(spacing: 6) {
                    Text("Don't have an account?")
                    Button("Sign Up") {
                        showSignUp.toggle()
                        
                    }
                    .fontWeight(.bold)
                    .tint(.teal)
                }
                .font(.callout)
                .hSpacing()
                
            })
            .padding(.vertical, 15)
            .padding(.horizontal, 45)
            .toolbar(.hidden, for: .navigationBar)
            .disabled(isLoading)
            
        }
    
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData())
//}
