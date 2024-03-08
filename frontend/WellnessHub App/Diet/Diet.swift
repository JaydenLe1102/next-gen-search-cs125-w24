//
//  Diet.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/14/24.
//

import SwiftUI

struct Diet: View {

    @State var caloriesNum: Double



    var body: some View {
        VStack{
            TopBar()
            Recipes()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserData())
}
