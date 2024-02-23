//
//  ColoredButton.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/7/24.
//

import SwiftUI

struct ColoredButton: View {
    var title: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            Text(title)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical,12)
            .padding(.horizontal,55)
            .background(.teal, in: .capsule)
        })
    }
}

#Preview {
    ContentView()
}
