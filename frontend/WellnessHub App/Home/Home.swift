//
//  HomeView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI


struct Home: View {
    @ObservedObject var userData: UserData
    @StateObject private var authManager = AuthenticationManager.shared
    
    @State private var selectedOption = "Week"
    @State private var score_percentage:Double = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 50 , content: {
            Text("Your current lifestyle progress for today")
                .padding(30)
                .font(.title)
            ZStack { // 1
                Circle()
                    .stroke(
                        Color.pink.opacity(0.5),
                        lineWidth: 30
                    )
                Circle() // 2
                    .trim(from: 0, to: userData.day_score_percentage)
                    .stroke(
                        Color.pink,
                        style: StrokeStyle(
                            lineWidth: 30,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))


                Text("\(Int(userData.day_score_percentage * 100))%") // Display progress percentage
                        .foregroundColor(.pink)
                        .font(.system(size: 20, weight: .semibold))

            }.frame(width: 250, height: 250)
            
        })
        
        .onAppear{
            Task{
                do{
                    try await userData.getScoreForDay(idToken: authManager.authToken)
                    
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
