//
//  CustomTabView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/20/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    
    let items: [(image: String, title: String)] = [
    ("house", "Home"),
    ("fork.knife", "Diet"),
    ("figure.run", "Exercise"),
    ("bed.double", "Sleep"),
    ("person", "Profile")]
    
    var body: some View {
        ZStack{
            HStack{
                ForEach(0..<5) {index in
                    Button{
                        selectedTab = index + 1
                    } label: {
                        VStack(spacing: 8) {
                            Spacer()
                            Image(systemName: items[index].image)
                            Text(items[index].title)
                        }
                        .foregroundColor(index + 1 == selectedTab ? .teal : .gray)
                        .frame(maxWidth: .infinity)

                    }
           
                }
            
            }
            .frame(height: 80)
        }
        .padding(.horizontal)
        
        
    }
}

#Preview {
//    CustomTabView(selectedTab: .constant(1))
    ContentView()
        .environmentObject(UserData())
}
