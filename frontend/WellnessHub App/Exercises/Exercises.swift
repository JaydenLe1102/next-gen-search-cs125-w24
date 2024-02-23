//
//  Exercise.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI

struct Exercises: View {

//    var recommendation: String


    var body: some View {
        
            VStack{
                TopBar()
                ScrollView(.vertical, showsIndicators: false,content: {
                VStack(alignment: .leading,content: {
                    Text("Running + Walking")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Exercise(distance: 1000, calories: 50, steps: 100)
                    

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

#Preview {
    ContentView()
}

