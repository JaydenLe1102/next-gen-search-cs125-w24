//
//  RecommendationModal.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/19/24.
//

import SwiftUI

struct RecommendationModal: View {
    var recommendation: String
    var imageURL: String
    
    @State private var isModalPresented = false


    var body: some View {
        VStack(alignment: .leading, content: {
                 VStack(spacing: 0) {
                    
                    Image(systemName: imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        
                    Text(recommendation)
                        .padding([.bottom, .horizontal])
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                 .frame(width: 135, height: 135 )
                 .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                .cornerRadius(13)
                .frame(width: 140)
        })
        
    }
}

#Preview {
    RecommendationModal(recommendation: "Sleep more pls", imageURL: "photo")
}
