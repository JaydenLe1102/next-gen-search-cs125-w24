//
//  UserInputs.swift
//  WellnessHub App
//
//  Created by BobaHolic on 3/1/24.
//

import SwiftUI




struct UserInputs: View {
    
    @EnvironmentObject var userData: UserData
    @StateObject private var authManager = AuthenticationManager.shared

    var body: some View {
        VStack(content: {
            VStack(alignment: .center, content: {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
                    .font(.title2)
                    .foregroundStyle(.teal)
                    .background(Color(red: 214/255, green: 239/255, blue: 244/255))
                    .cornerRadius(70.0)

                Text("Name")
            })
            .padding(40)

            VStack(alignment: .leading,spacing: 30, content: {
                HStack( content: {
                    Text("Age:")
                    TextField("Age", text: $userData.age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 210)
                        .padding(.leading)
                    Text("years old")
                        .foregroundColor(.secondary)
                
                })
                
                HStack(content: {
                    Text("Gender:")
                    Picker("Gender", selection: $userData.selectedGenderIndex) {
                        ForEach(0..<3) { index in
                            Text(UserData.genders[index])
                        }
                    }
                })
                
                HStack( content: {
                    Text("Weight:")
                    TextField("Weight", text: $userData.weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                    Text("lbs")
                        .foregroundColor(.secondary)
                })
                
                HStack(content: {
                    Text("Height: ")
                    TextField("Height", text: $userData.height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                    Text("ft")
                        .foregroundColor(.secondary)
                })
                        
                
                
                HStack(content: {
                    Text("Goal:")
                    Section {
                        Picker("Goals", selection: $userData.selectedGoalIndex) {
                            ForEach(0..<3) { index in
                                Text(UserData.goals[index])
                            }
                        }
                    }
                })
                
                HStack(content: {
                    Text("Activity Level:")

                    Section {
                        Picker("Activity Levels", selection: $userData.selectedActivityLvlIndex) {
                            ForEach(0..<3) { index in
                                Text(UserData.activityLevels[index])
                            }
                        }
                    }
                })
            })
            .padding()

            

            Button(action: {
                authManager.fakeLogin()
                userData.saveProfile()
            }) {
                Text("Save Profile")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.teal)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
            }
            .padding(20)

            Spacer()
        })
    }
}

#Preview {
    UserInputs()
}
