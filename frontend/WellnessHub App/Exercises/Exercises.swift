//
//  Exercise.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI


//delete after done getting exercise data vvv


//delete after done getting exercise data ^^^


struct Exercises: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var dietService: DietService
    @EnvironmentObject var healthManager: HealthkitManager
    @EnvironmentObject var sleepService: SleepService
    @EnvironmentObject var exerciseService: ExerciseService
    
    
    @StateObject private var authManager = AuthenticationManager.shared
    
    @State private var isModalPresented = false

    
    let icons = ["figure.cooldown", "figure.flexibility", "figure.strengthtraining.functional", "figure.basketball", "figure.strengthtraining.functional","figure.climbing"]
    
    
    var body: some View {
        
            VStack{
                TopBar()
                ScrollView(.vertical, showsIndicators: false,content: {
                VStack(alignment: .leading,content: {

                    HStack(spacing: 50, content: {
                        ZStack { // 1
                            Circle()
                                .stroke(
                                    Color.pink.opacity(0.5),
                                    lineWidth: 30
                                )
                            Circle() // 2
                                .trim(from: 0, to: exerciseService.exerciseScorePercentage)
                                .stroke(
                                    Color.pink,
                                    style: StrokeStyle(
                                        lineWidth: 30,
                                        lineCap: .round
                                    )
                                )
                                .rotationEffect(.degrees(-90))



                                Text("\(Int(exerciseService.exerciseScorePercentage * 100))%") // Display progress percentage
                                    .foregroundColor(.pink)
                                    .font(.system(size: 20, weight: .semibold))
                        }.frame(width: 150, height: 150)
                            .padding()
                        VStack(content: {
                            VStack{
                                VStack(alignment: .leading, content:  {
                                    Text("Calories burned")
                                    Text("\(String(format: "%.1f", healthManager.calories_burn_yesterday)) cal")
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
                                    Text("Your are on")
                                    Text("Day \(exerciseService.todayExercise)")
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
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        ForEach(exerciseService.exerciseData.sorted(by: { $0.key < $1.key }), id: \.key) { day, activities in
                            let dayNumber = String(day.dropFirst(4))
                            let iconIndex = Int(dayNumber)! - 1
                            VStack(alignment: .leading) {
                                Text("Day \(dayNumber)")
                                    .font(.title)
                                    .padding(.bottom, 10)
                                HStack {
                                    if Int(dayNumber) == 7 {
                                        ForEach(activities) { activity in
                                            
                                            Button(action: {
                                                isModalPresented.toggle()
                                            }) {
                                                ExerciseRecommendation(recommendation: activity.title, imageURL: "sparkles")
                                            }
                                            .sheet(isPresented: $isModalPresented) {
                                                VStack{
                                                    ExerciseModal(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks", imageURL: "photo")
                                                }
                                                .padding()
                                            }
                                            
                                        }
                                        Spacer()
                                    }
                                    else {
                                        ForEach(0..<activities.count) { index in
                                            let imageURL = icons[index]
                                            Button(action: {
                                                isModalPresented.toggle()
                                            }) {
                                                ExerciseRecommendation(recommendation: activities[index].title, imageURL: imageURL)
                                            }
                                            .sheet(isPresented: $isModalPresented) {
                                                VStack{
                                                    ExerciseModal(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks", imageURL: "photo")
                                                }
                                                .padding()
                                            }
                                        }
                                        
                                    }
                                    
                                }
                                .padding(.bottom, 10)
                            }
                            .padding(.top, 10)
                        }
                    })

                })
                
                Spacer()
                })
            }
            .padding(.horizontal,20)

        }
    
}

//#Preview {
//    Exercises()
//        .environmentObject(userData)
//        .environmentObject(dietService)
//        .environmentObject(healthKitManager)
//        .environmentObject(sleepService)
//        .environmentObject(exerciseService)
//        .environmentObject(loginSignUpService)
//}

