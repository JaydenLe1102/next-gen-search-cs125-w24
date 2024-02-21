//
//  CustomTabView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/20/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    @Namespace private var animation
    
    let items: [(image: String, title: String)] = [
    ("house", "Home"),
    ("house", "Diet"),
    ("house", "Exercises"),
    ("house", "Sleep"),
    ("house", "Profile"),
    ]
    
    var body: some View {
        ZStack{
//            Capsule()
//                .frame(height: 80)
//                .foregroundColor(Color(.secondarySystemBackground))
//                .shadow(radius: 2)
            
            HStack{
                ForEach(0..<5) {index in
                    Button{
                        selectedTab = index + 1
                    } label: {
                        VStack(spacing: 8) {
                            Spacer()
                            
                            Image(systemName: items[index].image)
                            Text(items[index].title)
                            
                            if index + 1 == selectedTab {
                                Capsule()
                                    .frame(height:  8)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animation)
                                    .offset(y:3)
                            }
                            else {
                                Capsule()
                                    .frame(height:  8)
                                    .foregroundColor(.clear)
                                    .offset(y:3)
                            }
                        }
                        .foregroundColor(index + 1 == selectedTab ? .blue : .gray)
                        
                    }
                }
            }
            .frame(height: 80)
//            .foregroundColor(Color(.gray))
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    CustomTabView(selectedTab: .constant(1))
        .previewLayout(.sizeThatFits)
        .padding(.vertical)
}
