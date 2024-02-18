//
//  Searchbar.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/17/24.
//

import SwiftUI

struct Searchbar: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Search", text: $searchText)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            .shadow(color: Color.gray.opacity(0.2), radius: 2, x: 0, y: 2)
            .padding(.horizontal)
            
    }
}

struct Searchbar_Previews: PreviewProvider {
    static var previews: some View {
        Searchbar(searchText: .constant(""))
    }
}

