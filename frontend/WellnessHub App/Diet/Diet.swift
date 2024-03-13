//
//  Diet.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/14/24.
//

import SwiftUI

struct Diet: View {

    @EnvironmentObject var dietService: DietService
    @StateObject private var authManager = AuthenticationManager.shared


    var body: some View {
        VStack{
            TopBar()
            
            
            ScrollView(.vertical, showsIndicators: false,content: {
            VStack(alignment: .leading,content: {
                Text("Food Analysis")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                HStack(spacing: 20, content: {
                    ZStack { // 1
                        Circle()
                            .stroke(
                                Color.pink.opacity(0.5),
                                lineWidth: 25
                            )
                        Circle() // 2
                            .trim(from: 0, to: dietService.dietProgressPercentage)
                            .stroke(
                                Color.pink,
                                style: StrokeStyle(
                                    lineWidth: 25,
                                    lineCap: .round
                                )
                            )
                            .rotationEffect(.degrees(-90))



                            Text("\(Int(dietService.dietProgressPercentage * 100))%") // Display progress percentage
                                .foregroundColor(.pink)
                                .font(.system(size: 20, weight: .semibold))
                    }
                .frame(width: 150, height: 150)
                        .padding()
                    
                    
                    VStack(content: {
                        VStack{
                            VStack(alignment: .leading, content:  {
                                Text("Recommended")
                                Text("\(String(format: "%.1f", dietService.caloriesIntakeRec)) cal")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            })
                            .padding()
                        }
                        .frame(width: 150)
                        .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                        .cornerRadius(13)
                        
                        VStack{
                            VStack(alignment: .leading, content:  {
                                Text("Consumed")
                                Text("\(String(format: "%.1f", dietService.caloriesConsume)) cal")
                                    .font(.title2)
                                    .fontWeight(.semibold)
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
                
                
                Recipes()

            })
            .padding(.horizontal,20)
            Spacer()
            })
            
            
            
        }
        .onAppear{
            Task{
                do{
                    try await dietService.getDietScore(idToken: authManager.authToken)
                    
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

