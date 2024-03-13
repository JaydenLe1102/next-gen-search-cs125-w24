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
                        .frame(width: 50, height: 40)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .foregroundColor(.black)

                        
                    Text(recommendation)
                        .padding([.bottom, .horizontal])
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .foregroundColor(.black)
                }
                 .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                .cornerRadius(13)
        })
        
    }
}

#Preview {
    RecommendationModal(recommendation: "Sleep more pls", imageURL: "photo")
}
