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
                    HStack(spacing: 20, content: {
                        ZStack { // 1
                            Circle()
                                .stroke(
                                    Color.pink.opacity(0.5),
                                    lineWidth: 25
                                )
                            Circle() // 2
                                .trim(from: 0, to: sleepService.sleepProgressPercentage)
                                .stroke(
                                    Color.pink,
                                    style: StrokeStyle(
                                        lineWidth: 25,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))

                                Text("\(Int(sleepService.sleepProgressPercentage * 100))%") // Display progress percentage
                                    .foregroundColor(.pink)
                                    .font(.system(size: 20, weight: .semibold))
                        }.frame(width: 150, height: 150)
                            .padding()
                        
                        VStack(content: {
                            VStack{
                                VStack(alignment: .leading, content:  {
                                    Text("Sleep duration yesterday")
                                    Text(Utils.convertSecondsToHoursMinutes(healthManager.sleep_time_yesterday))
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.pink)
                                })
                                .padding()
                            }
                            .frame(width: 150)
                            .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                            .cornerRadius(13)
                            
                            
                            VStack{
                                VStack(alignment: .leading, content:  {
                                    Text("Sleep duration recommended")
                                    Text("\(sleepService.sleepRecHour) hour(s)")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.pink)

                                })
                                .padding()
                            }
                            .frame(width: 150)
                            .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                            .cornerRadius(13)
                        })
                    })
                    
                    Text("Recommendations")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(.top,20)
                    
                    VStack(content: {
                        RecommendationModal(recommendation: sleepService.sleepMessageRecommendation2, imageURL: "bed.double")
                            .frame(width: 350)
                        RecommendationModal(recommendation: sleepService.sleepMessageRecommendation, imageURL: "bed.double")
                            .frame(width: 350)
                        
                        
                    })
                    
                    
                })
                .padding(.horizontal,20)
                Spacer()
            })
        }
        .onAppear{
            Task{
                do{
                    try await sleepService.fetch_sleep_rec_point(idToken: authManager.authToken, sleep_time_yesterday: healthManager.sleep_time_yesterday)
                    
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
