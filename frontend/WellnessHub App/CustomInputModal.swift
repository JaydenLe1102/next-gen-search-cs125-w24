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
        userData.last_update_weight = userData.formatter.string(from: Date())
        
        userData.saveProfile()
    }
    

    var body: some View {
        VStack(alignment: .center, content: {
            Text("Enter Your Current Weight")
                .font(.headline)
                .padding()
            
            TextField("Weight", text: $userData.weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            Button(action: {
                updateWeight()
                isWeightModalPresented = false
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.teal)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
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

//#Preview {
//    ContentView()
//        .environmentObject(UserData(healthKitManager: healthKitManager))
//}
