//
//  DropDownView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI

struct DropDownComponent: View {
    let title: String
    let prompt: String
    let options: [String]
    
    @State private var isExpanded = false
//    @Binding var selection
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.footnote)
                .foregroundStyle(.gray)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Text(prompt)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))

                    

                }
                .frame(height:40)
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation(.snappy) {isExpanded.toggle()}
                }
            }
            if isExpanded {
                VStack {
                    ForEach(options, id:\.self) {option in
                        HStack {
                            Text(option)
                            
                            Spacer()
                            
                        }
                        .frame(height: 40)
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    DropDownComponent(title: "Summary in", prompt: "Select", options: ["Day","Week","Month"])
}
