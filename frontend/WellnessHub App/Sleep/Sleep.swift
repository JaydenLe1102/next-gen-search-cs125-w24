//
//  Sleep.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI

struct Sleep: View {
    var body: some View {
        VStack{
            TopBar()
            ScrollView(.vertical, showsIndicators: false,content: {
                VStack(alignment: .leading, spacing: 20 , content: {
                    Text("Sleep Analysis")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    HStack(content: {
                        TotalTime(normal: true, duration: "9 hours")
                        ExactTime(sleepTime: "9:50 PM", wakeUpTime: "6:50 AM")
                    })
                    Text("Recommendations")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding(.top,20)
                    ScrollView(.horizontal, showsIndicators: false,content: {
                        HStack(content: {
                            RecommendationModal(recommendation: "Sleep more plssss", imageURL: "photo")
                            RecommendationModal(recommendation: "Sleep more pls", imageURL: "photo")
                            RecommendationModal(recommendation: "Sleep more pls", imageURL: "photo")
                            RecommendationModal(recommendation: "Sleep more pls", imageURL: "photo")
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
    Sleep()
}
