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
    
    let icons = ["figure.cooldown", "figure.flexibility", "figure.strengthtraining.functional", "figure.basketball", "figure.strengthtraining.functional","figure.climbing"]

    
    let exerciseData: [String: [ExerciseActivity]] = [
        "day_1": [
            ExerciseActivity(calories_burned: 75, instructions: "5-minute jog followed by 1-minute sprint intervals for a total of 5 minutes.", length: "5 minutes", title: "Cardio Interval Training"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform bodyweight squats continuously for 5 minutes.", length: "5 minutes", title: "Bodyweight Squats"),
            ExerciseActivity(calories_burned: 40, instructions: "Hold the plank position for 5 minutes.", length: "5 minutes", title: "Plank"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform as many push-ups as possible in 5 minutes.", length: "5 minutes", title: "Push-Ups"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform mountain climbers continuously for 5 minutes.", length: "5 minutes", title: "Mountain Climbers")
        ],
        "day_2": [
            ExerciseActivity(calories_burned: 75, instructions: "5-minute jog followed by 1-minute sprint intervals for a total of 5 minutes.", length: "5 minutes", title: "Cardio Interval Training"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform bodyweight squats continuously for 5 minutes.", length: "5 minutes", title: "Bodyweight Squats"),
            ExerciseActivity(calories_burned: 40, instructions: "Hold the plank position for 5 minutes.", length: "5 minutes", title: "Plank"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform as many push-ups as possible in 5 minutes.", length: "5 minutes", title: "Push-Ups"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform mountain climbers continuously for 5 minutes.", length: "5 minutes", title: "Mountain Climbers")
        ],
        "day_3": [
            ExerciseActivity(calories_burned: 75, instructions: "5-minute jog followed by 1-minute sprint intervals for a total of 5 minutes.", length: "5 minutes", title: "Cardio Interval Training"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform bodyweight squats continuously for 5 minutes.", length: "5 minutes", title: "Bodyweight Squats"),
            ExerciseActivity(calories_burned: 40, instructions: "Hold the plank position for 5 minutes.", length: "5 minutes", title: "Plank"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform as many push-ups as possible in 5 minutes.", length: "5 minutes", title: "Push-Ups"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform mountain climbers continuously for 5 minutes.", length: "5 minutes", title: "Mountain Climbers")
        ],
        "day_4": [
            ExerciseActivity(calories_burned: 75, instructions: "5-minute jog followed by 1-minute sprint intervals for a total of 5 minutes.", length: "5 minutes", title: "Cardio Interval Training"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform bodyweight squats continuously for 5 minutes.", length: "5 minutes", title: "Bodyweight Squats"),
            ExerciseActivity(calories_burned: 40, instructions: "Hold the plank position for 5 minutes.", length: "5 minutes", title: "Plank"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform as many push-ups as possible in 5 minutes.", length: "5 minutes", title: "Push-Ups"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform mountain climbers continuously for 5 minutes.", length: "5 minutes", title: "Mountain Climbers")
        ],"day_5": [
            ExerciseActivity(calories_burned: 75, instructions: "5-minute jog followed by 1-minute sprint intervals for a total of 5 minutes.", length: "5 minutes", title: "Cardio Interval Training"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform bodyweight squats continuously for 5 minutes.", length: "5 minutes", title: "Bodyweight Squats"),
            ExerciseActivity(calories_burned: 40, instructions: "Hold the plank position for 5 minutes.", length: "5 minutes", title: "Plank"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform as many push-ups as possible in 5 minutes.", length: "5 minutes", title: "Push-Ups"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform mountain climbers continuously for 5 minutes.", length: "5 minutes", title: "Mountain Climbers")
        ],"day_6": [
            ExerciseActivity(calories_burned: 75, instructions: "5-minute jog followed by 1-minute sprint intervals for a total of 5 minutes.", length: "5 minutes", title: "Cardio Interval Training"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform jumping jacks continuously for 5 minutes.", length: "5 minutes", title: "Jumping Jacks"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform bodyweight squats continuously for 5 minutes.", length: "5 minutes", title: "Bodyweight Squats"),
            ExerciseActivity(calories_burned: 40, instructions: "Hold the plank position for 5 minutes.", length: "5 minutes", title: "Plank"),
            ExerciseActivity(calories_burned: 50, instructions: "Perform as many push-ups as possible in 5 minutes.", length: "5 minutes", title: "Push-Ups"),
            ExerciseActivity(calories_burned: 60, instructions: "Perform mountain climbers continuously for 5 minutes.", length: "5 minutes", title: "Mountain Climbers")
        ],"day_7": [
            ExerciseActivity(calories_burned: 75, instructions: "Rest", length: "0 minutes", title: "Rest"),
        ],
    ]

    
    
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
                                            RecommendationModal(recommendation: activity.title, imageURL: "sparkles")
                                        }
                                        Spacer()
                                    }
                                    else {
                                        ForEach(0..<activities.count) { index in
                                                            let imageURL = icons[index]
                                                            RecommendationModal(recommendation: activities[index].title, imageURL: imageURL)
                                                        }
                                        
                                    }
                                    
                                }
                                .padding(.bottom, 10)
                            }
                            .padding(.top, 10)
                        }
                    })

                })
                .padding(.horizontal,20)
                Spacer()
                })
            }

        }
}

//#Preview {
//    Exercises()
//}

