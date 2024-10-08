// CircularProgressView.swift
// WellnessHub App
//
// Created by JetnutShark on 3/11/24.
//

import SwiftUI

struct CircularProgressView: View {
//    @State var progress: Double

    @State var currentProgress: Double
    @State private var showText = false

    var body: some View {
        ZStack { // 1
            Circle()
                .stroke(
                    Color.pink.opacity(0.5),
                    lineWidth: 30
                )
            Circle() // 2
                .trim(from: 0, to: currentProgress)
                .stroke(
                    Color.pink,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .onAppear {
//                    withAnimation(.linear(duration: 1.0)) { // Adjust duration as needed
//                        currentProgress = progress
//                    }
                    showText = true
                }

            if showText {
                Text("\(Int(currentProgress * 100))%") // Display progress percentage
                    .foregroundColor(.pink)
                    .font(.system(size: 20, weight: .semibold))
            }
        }
        .onAppear{
            currentProgress = 0
            showText = false
        }
        
    }
        
}

//#Preview {
//  CircularProgressView(progress: 0.75)
//}
