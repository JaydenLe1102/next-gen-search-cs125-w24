//
//  CustomInputModal.swift
//  WellnessHub App
//
//  Created by BobaHolic on 3/3/24.
//

import SwiftUI

struct CustomInputModal: View {
    @Binding var isWeightModalPresented: Bool
    @Binding var currentWeight: String
    
    @EnvironmentObject var userData: UserData

    
    func updateWeight() {

        userData.weight = userData.weight.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    

    var body: some View {
        VStack(alignment: .center, content: {
            Text("Enter Your Current Weight")
                .font(.headline)
                .padding()
            
            TextField("Weight", text: $userData.weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                updateWeight()
                isWeightModalPresented = true
            }
            .padding()
        }
               
        )
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

#Preview {
    CustomInputModal(isWeightModalPresented: .constant(true), currentWeight: .constant("150"))
}
