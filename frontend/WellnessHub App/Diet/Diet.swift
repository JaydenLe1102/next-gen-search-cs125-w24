//
//  Diet.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/14/24.
//

import SwiftUI

struct Diet: View {

    @EnvironmentObject var dietService: DietService

    var body: some View {
        VStack{
            TopBar()
            
            
            ScrollView(.vertical, showsIndicators: false,content: {
            VStack(alignment: .leading,content: {
                Text("Food Analysis")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                HStack(spacing: 50, content: {
                    CircularProgressView(progress: dietService.dietProgressPercentage).frame(width: 150, height: 150)
                        .padding()
                    
                    
                    VStack(content: {
                        VStack{
                            VStack(alignment: .leading, content:  {
                                Text("Calories recommended")
                                Text(String(dietService.caloriesIntakeRec))
                                    .font(.system(size: 30))
                            })
                            .padding()
                        }
                        .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                        .cornerRadius(13)
                        
                        VStack{
                            VStack(alignment: .leading, content:  {
                                Text("Calories consumed")
                                Text(String(dietService.caloriesConsume))
                                    .font(.system(size: 30))
                            })
                            .padding()
                            
                        }
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
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData(healthKitManager: HealthkitManager()))
//        .environmentObject(DietService())
//        .environmentObject(HealthkitManager())
//}

