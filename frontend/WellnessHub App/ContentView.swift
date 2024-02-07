//
//  ContentView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .background(.red)
                .tabItem { Label("Home", systemImage: "1.circle") }
            
            Text("Diet")
                .background(.cyan)
                .tabItem { Label("Diet", systemImage: "1.circle") }
            Text("Exercise")
                .background(.blue)
                .tabItem { Label("Exercise", systemImage: "1.circle") }
            Text("Sleep")
                .background(.yellow)
                .tabItem { Label("Sleep", systemImage: "1.circle") }
            Text("Profile")
                .background(.pink)
                .tabItem { Label("Profile", systemImage: "1.circle") }
        }
    }
}

#Preview {
    ContentView()
}
