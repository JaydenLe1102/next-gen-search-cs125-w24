//
//  TotalTime.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI


struct TotalTime: View {
    var normal: Bool
    var duration: String
    
    
    var body: some View {
        VStack{
            VStack(content: {
                HStack{
                    VStack(alignment:.leading, content: {
                        Text("Total time in bed")
                            .font(.system(size: 30))
                        Text(normal ? "Result is normal" : "Result is not normal")
                            .font(.title2)
                            .foregroundColor(normal ? .green : .red)
                    })
                }
                Text(duration)
                    .font(.system(size: 50))
                
            })
            .padding()
            .background(Color(red: 214/255, green: 239/255, blue: 244/255)
)
            
            
        }
        .cornerRadius(13)
        
    }
}

#Preview {
//    TotalTime(normal: true, duration: "9 hours")
    Sleep()
}
