

//
//  LogIn.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI

struct LogIn: View {
    @Binding var showSignUp: Bool
    //view properties
    @State private var emailID: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing:15, content: {
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .hSpacing()
            
//            Text("Please sign in to continue")
//                .font(.callout)
//                .fontWeight(.semibold)
//                .foregroundStyle(.gray)
//                .padding(.top, -5)
            
            VStack(spacing: 25) {
                //Custom  Text Field
                CustomTextField(icon: "at", hint: "Email ID", value: $emailID)
                
                CustomTextField(icon: "lock", hint: "Password", isPassword: true, value: $password)
                    .padding(.top, 5)
                
                Button("Forgot Password?") {
                    
                }
                
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.yellow)
                .hSpacing()
                
                //login button
                ColoredButton(title: "Login") {
                    
                }
                //disabling until the email and pw are entered
                .disableWithOpacity(emailID.isEmpty || password.isEmpty)

            }
            .padding(.top,20)
            

            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            HStack(spacing: 6) {
                Text("Don't have an account?")
                Button("Sign Up") {
                    showSignUp.toggle()
                    
                }
                .fontWeight(.bold)
                .tint(.yellow)
            }
            .font(.callout)
            .hSpacing()
            
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 45)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    ContentView()
}
