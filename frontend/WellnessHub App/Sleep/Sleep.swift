//
//  Sleep.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI

struct Sleep: View {
    @EnvironmentObject var healthManager: HealthkitManager
    @EnvironmentObject var sleepService: SleepService
    @StateObject private var authManager = AuthenticationManager.shared
    var body: some View {
        VStack{
            TopBar()
            ScrollView(.vertical, showsIndicators: false,content: {
                VStack(alignment: .leading, spacing: 20 , content: {
                    Text("Sleep Analysis")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    HStack(spacing: 50, content: {
                        ZStack { // 1
                            Circle()
                                .stroke(
                                    Color.pink.opacity(0.5),
                                    lineWidth: 30
                                )
                            Circle() // 2
                                .trim(from: 0, to: sleepService.sleepProgressPercentage)
                                .stroke(
                                    Color.pink,
                                    style: StrokeStyle(
                                        lineWidth: 30,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))



                                Text("\(Int(sleepService.sleepProgressPercentage * 100))%") // Display progress percentage
                                    .foregroundColor(.pink)
                                    .font(.system(size: 20, weight: .semibold))
                        }.frame(width: 150, height: 150)
                            .padding()
                        
                        VStack{
                            VStack(alignment: .leading, content:  {
                              Text("Sleep time yesterday")
                                Spacer()
                                Text("\(String(format: "%.1f", healthManager.sleep_time_yesterday)) seconds")
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
                            RecommendationModal(recommendation: sleepService.sleepMessageRecommendation, imageURL: "photo")
                        })
                    })
                    
                })
                .padding(.horizontal,20)
                Spacer()
            })
        }
        .onAppear{
            Task{
                do{
                    try await sleepService.fetch_sleep_rec_point(idToken: authManager.authToken)
                    
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
