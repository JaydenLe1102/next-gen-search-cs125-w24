//
//  HomeView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI


struct Home: View {
    @EnvironmentObject var healthManager: HealthkitManager

    @State private var selectedOption = "Week"
    
    var body: some View {
        Text("\(healthManager.calories_burn_yesterday)")
                VStack {
                    Text("Hello, Home!")
        
                    Picker("Select Time", selection: $selectedOption) {
                        Text("Day").tag("Day")
                        Text("Week").tag("Week")
                        Text("Month").tag("Month")
                    }
                }
                .toolbar(content: {
                    Button {
                        // Action for Day button
                    } label: {
                        Text("Day")
                    }
        
                    Button {
                        // Action for Week button
                    } label: {
                        Text("Week")
                    }
        
                    Button {
                        // Action for Month button
                    } label: {
                        Text("Month")
                    }
                })
            }
 
    }
#Preview {
    Home()
}

//extension View {
//    func getRect() ->CGRect{
//        return UIScreen.main.bounds
//    }
//}
