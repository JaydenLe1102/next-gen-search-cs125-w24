//
//  Exercise.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI

struct Exercise: View {
    var distance: Double
    var calories: Double
    var steps: Double

    
    var body: some View {
        VStack(alignment: .leading, content: {
            
            VStack(alignment: .leading, content: {
                VStack(alignment: .leading, content: {
                    HStack(content: {
                        Text("Distance")
                        Spacer()
                        Text("\(String(format: "%.1f", distance)) mi")
                      .font(.title)
                    })
                    
                })

                .padding()
                .frame(maxWidth: .infinity)
            })
            .background(Color.black.opacity(0.08))
            .cornerRadius(13)
            
            VStack(alignment: .leading, content: {
                VStack(alignment: .leading, content: {
                    HStack(content: {
                        Text("Calories burned")
                        Spacer()
                        Text("\(String(format: "%.1f", calories)) cal")
                      .font(.title)
                    })
                    
                })
                .padding()
                .frame(maxWidth: .infinity)

            })
            .background(Color.black.opacity(0.08))
            .cornerRadius(13)
            
            VStack(alignment: .leading, content: {
                VStack(alignment: .leading, content: {
                    HStack(content: {
                        Text("Steps")
                        Spacer()
                        Text("\(String(format: "%.1f", steps)) steps")
                      .font(.title)
                    })
                    
                })
                .padding()
                .frame(maxWidth: .infinity)

            })
            .background(Color.black.opacity(0.08))
            .cornerRadius(13)
        })
    }
}

#Preview {
    Exercise(distance: 1000, calories: 50, steps: 100)
}
