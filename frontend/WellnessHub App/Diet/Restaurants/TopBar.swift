//
//  TopBar.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .font(.title2)
                    .padding(10)
                    .background(.black.opacity(0.08))
                    .foregroundStyle(.teal)
                    .cornerRadius(25.0)
            }
        }
        .overlay(
            HStack(spacing: 10) {
                Image(systemName: "mappin")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.teal)

                Text("California, US")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
        )
        .padding()
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}

