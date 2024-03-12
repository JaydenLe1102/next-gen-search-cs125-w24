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
    @State private var isModalPresented = false

    var body: some View {
        NavigationView(content: {
            ScrollView(content: {
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
                        Text("lbs")
                            .foregroundColor(.secondary)
                    })
                    .frame(maxWidth: UIScreen.main.bounds.width)

                    
                    HStack(content: {
                        Text("Height: ")
                        TextField("Height", text: $userData.height)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("ft")
                            .foregroundColor(.secondary)
                    })
                    .frame(maxWidth: UIScreen.main.bounds.width)

                            
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
                    
                    HStack( content: {
                        Text("Target weight:")
                        TextField("Target weight", text: $userData.target_weight)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .disabled(userData.selectedGoalIndex == 2)
                        Text("lbs")
                            .foregroundColor(.secondary)
                    })
                    
                    

                })
                .padding()
                
                NavigationLink(destination: Profile(), isActive: $isModalPresented) {
                    EmptyView()
                }
                .hidden()
                Button(action: {
                    if authManager.isAuthenticated == true {
                        isModalPresented = true
                        userData.saveProfile()
                    }
                    else {
                        authManager.fakeLogin()
                        userData.saveProfile()
                    }
                    
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
            .padding()
        })
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    UserInputs()
//        .environmentObject(UserData(healthKitManager: HealthkitManager()))
//        .environmentObject(DietService())
//        .environmentObject(HealthkitManager())
//}
