//
//  SignUp.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/8/24.
//

import SwiftUI

struct SignUp: View {
    @Binding var showSignUp: Bool
    //view properties
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var confirmedPassword: String = ""
    @Binding var selectedTab: Int
    
    @State private var isModalPresented = false
    
    @EnvironmentObject var userData: UserData



    @StateObject private var loginSignupService = LoginSignupService.shared
    @StateObject private var authManager = AuthenticationManager.shared



    var body: some View {
        VStack(alignment: .leading, spacing:50, content: {
                        
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .hSpacing()
            
            VStack(spacing: 25) {
                
                CustomTextField(icon: "at", hint: "Email ID", value: $emailID)
                
               
                
                CustomTextField(icon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                CustomTextField(icon: "lock", hint: "Confirm Password", isPassword: true, value: $confirmedPassword)
                    .padding(.top, 5)
                
                NavigationLink(destination: UserInputs(isFromSignUp: true), isActive: $isModalPresented) {
                                        EmptyView()
                                    }
                                    .hidden()                
                Button(action: {
                    
                    loginSignupService.signup(email: emailID, password: password){ result in
                        switch result {
                        case .success(let tokens):
                            print("Sign Up successful. idToken: \(tokens.idToken), userID: \(tokens.userID)")
                            authManager.signUp(withToken: tokens.idToken, userId: tokens.userID)
                            isModalPresented = true

                        case .failure(let error):
                            print("Sign Up failed: \(error)")
                        }
                    }
                    
                    
                }) {
                    Text("Sign up")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.teal)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                }
//                    loginSignupService.signup(email: emailID, password: password){ result in
//                        switch result {
//                        case .success():
//                            print("Sign Up successful")
//    
//                        case .failure(let error):
//                            print("Sign Up failed: \(error)")
//                        }
//                    }
                


                //disabling until the email and pw are entered
//                .disableWithOpacity(fullName.isEmpty || emailID.isEmpty ||  password.isEmpty || confirmedPassword.isEmpty)

            }
            

            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            HStack(spacing: 6) {
                Text("Already have an account?")
                Button("Log In") {
                    showSignUp = false
                    
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
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData())
//}
