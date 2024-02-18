//
//  HomeView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/6/24.
//

import SwiftUI

struct Restaurants: View {
    
    var body: some View {

            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: 10){
                    
//                    this part should be looping by restaurant's ID
                    RestaurantModal(name: "Recently vistied 1", rating: 2,status:"Closed", location:"Irvine, CA", imageURL: "photo")
                    
                    RestaurantModal(name: "Recently vistied 2", rating: 5,status:"Open", location:"Laguna, CA", imageURL: "photo")
                    
                    RestaurantModal(name: "Recently vistied 3", rating: 3.5,status:"Open", location:"Irvine, CA", imageURL: "photo")
                    
                    RestaurantModal(name: "Recently vistied 4", rating: 4.5, status:"Closed", location:"Irvine, CA",imageURL: "photo")
                    
                    RestaurantModal(name: "Recently vistied 5", rating: 4.5, status:"Closed", location:"Costa Mesa, CA",imageURL: "photo")
                        
                }
            })
    }
}
#Preview {
    Diet()
}

extension View {
    func getRect() ->CGRect{
        return UIScreen.main.bounds
    }
}
