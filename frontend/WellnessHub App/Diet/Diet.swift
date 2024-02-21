//
//  Diet.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/14/24.
//

import SwiftUI

struct Diet: View {
    @State private var searchText: String = ""
    @State private var selectedOption: Int = 0


    var body: some View {
        VStack{
            TopBar()
            Picker(selection: $selectedOption, label: Text("")) {
                            Text("Restaurants").tag(0)
                            Text("Recipes").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        

                        if selectedOption == 0 {
                                    NavigationStack {
                                        Restaurants()
                                            .padding(.vertical)
                                    }
                                    .background(Color(.systemBackground))
                                    .searchable(text: $searchText)
                        } else {
                                    NavigationStack {
                                        Recipes()
                                            .padding(.vertical)
                                    }
                                    .background(Color(.systemBackground))
                                    .searchable(text: $searchText)
                        }
        }
    }
}

#Preview {
    ContentView()
}
