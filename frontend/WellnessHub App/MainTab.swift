//
//  MainTab.swift
//  WellnessHub App
//
//  Created by JetnutShark on 2/21/24.
//

import SwiftUI

struct MainTab: View {
    @Binding var selectedTab: Int
    var body: some View {
        TabView(selection: $selectedTab) {
            Home().tag(1)
            
            Diet().tag(2)
            
            Exercises().tag(3)

            
            Sleep().tag(4)
            
            Profile().tag(5)

        }
        .overlay(alignment: .bottom, content: {
            CustomTabView(selectedTab: $selectedTab)
        })
    }
}

//#Preview {
//    MainTab()
//}
