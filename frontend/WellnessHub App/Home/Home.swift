//
//  HomeView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI


struct Home: View {
    @EnvironmentObject var userData: UserData
    
    @State private var selectedOption = "Week"
    
    var body: some View {
        VStack(alignment: .center, spacing: 50 , content: {
            Text("Your current lifestyle progress for today")
                .padding(30)
                .font(.title)
            CircularProgressView(progress: userData.week_score_percentage).frame(width: 250, height: 250)
        })
        .onAppear{
            Task{
                do{
                    try await userData.getScoreForWeek()
                }
                catch{
                    
                }
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
