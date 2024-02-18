//
//  HomeView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI

struct Home: View {
    @State private var selectedOption = "Week"
    
    var body: some View {
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
            struct HomeView_Previews: PreviewProvider {
                static var previews: some View {
                    Home()
                }
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
