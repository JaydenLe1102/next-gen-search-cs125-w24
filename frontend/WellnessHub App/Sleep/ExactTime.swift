//
//  ExactTime.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI
    

struct ExactTime: View {
    var sleepTime: String
    var wakeUpTime: String
    var body: some View {
        VStack(content: {
            VStack{
                VStack(alignment: .leading, content:  {
                    Text("Went to sleep")
                    Text(sleepTime)
                        .font(.system(size: 30))
                })
                .padding()
            }
            .background(Color.black.opacity(0.08))
            .cornerRadius(13)
            
            VStack{
                VStack(alignment: .leading, content:  {
                    Text("Woke up")
                    Text(wakeUpTime)
                        .font(.system(size: 30))
                })
                .padding()
                
            }
            .background(Color.black.opacity(0.08))
            .cornerRadius(13)
        })

    }
}

#Preview {
    ExactTime(sleepTime: "9:50 PM", wakeUpTime: "6:50 PM")
}
