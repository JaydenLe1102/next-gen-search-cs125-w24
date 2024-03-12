//
//  Exercise.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI

struct Exercises: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var dietService: DietService
    @EnvironmentObject var healthManager: HealthkitManager
    @EnvironmentObject var sleepService: SleepService
    
    
    @StateObject private var authManager = AuthenticationManager.shared
    var body: some View {
        
            VStack{
                TopBar()
                ScrollView(.vertical, showsIndicators: false,content: {
                VStack(alignment: .leading,content: {

                    HStack(spacing: 50, content: {
                        CircularProgressView(progress: 0.75).frame(width: 150, height: 150)
                            .padding()
                        
                        VStack{
                            VStack(alignment: .leading, content:  {
                              Text("Calories burned")
                                Spacer()
                                Text("\(String(format: "%.1f", healthManager.calories_burn_yesterday)) cal")
                              .font(.title)
                            })
                            .padding()
                        }
                        .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                        .cornerRadius(13)
                    })
                    
                    Text("Recommendations")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(.top,20)
                    ScrollView(.horizontal, showsIndicators: false,content: {
                        HStack(content: {
                            RecommendationModal(recommendation: "recommendation", imageURL: "photo")
                            RecommendationModal(recommendation: "recommendation", imageURL: "photo")
                            RecommendationModal(recommendation: "recommendation", imageURL: "photo")
                            RecommendationModal(recommendation: "recommendation", imageURL: "photo")
                        })
                    })
                })
                .padding(.horizontal,20)
                Spacer()
                })
            }

        }
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData(healthKitManager: HealthkitManager()))
//        .environmentObject(DietService())
//        .environmentObject(HealthkitManager())
//}

