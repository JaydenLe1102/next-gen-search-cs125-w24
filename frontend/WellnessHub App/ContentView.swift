//
//  ContentView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    //view properties
    @State private var showSignUp: Bool = false
    @State private var showHome: Bool = false


    var body: some View {
        NavigationStack {
            LogIn(showSignUp: $showSignUp, showHome: $showHome)
                .navigationDestination(isPresented: $showSignUp) {
                    SignUp(showSignUp: $showSignUp)

                }
            
            
        }
        .background(Color(.systemBackground))

    }
    

}

#Preview {
    ContentView()
}
