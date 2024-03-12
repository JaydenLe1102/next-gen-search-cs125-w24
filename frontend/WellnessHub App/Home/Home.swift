//
//  HomeView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI


struct Home: View {
    @EnvironmentObject var userData: UserData
    @StateObject private var authManager = AuthenticationManager.shared
    
    @State private var selectedOption = "Week"
    @State private var score_percentage:Double = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 50 , content: {
            Text("Your current lifestyle progress for today")
                .padding(30)
                .font(.title)
            CircularProgressView(progress: score_percentage).frame(width: 250, height: 250)
        })
        .onAppear{
            Task{
                do{
                    try await userData.getScoreForDay(idToken: authManager.authToken)
                    
                    score_percentage = userData.day_score_percentage
                }
                catch{}
            }
        }
        
    }
    
}
//#Preview {
//    ContentView()
//        .environmentObject(UserData(healthKitManager: HealthkitManager()))
//        .environmentObject(DietService())
//        .environmentObject(HealthkitManager())
//}
//extension View {
//    func getRect() ->CGRect{
//        return UIScreen.main.bounds
//    }
//}
