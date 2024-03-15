//
//  UserInputs.swift
//  WellnessHub App
//
//  Created by BobaHolic on 3/1/24.
//

import SwiftUI




struct UserInputs: View {
    
    var isFromSignUp: Bool = false
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var dietService: DietService
    @EnvironmentObject var healthManager: HealthkitManager
    @EnvironmentObject var sleepService: SleepService
    @EnvironmentObject var exerciseService: ExerciseService
    
    
    @StateObject private var authManager = AuthenticationManager.shared
    @State private var isModalPresented = false
    
    @State private var isSaveEnable = false
    @State private var isLoading = false
    
    @State private var showAlert = false

    
    func fake_fetch_calories_burn_and_update() async throws{
        
        let calories = 609.9019999999992

        let param: [String:Any] = [
            "idToken": authManager.authToken,
            "calories_burn_yesterday": calories
        ]
        
        healthManager.calories_burn_yesterday = calories
        
        try await userData.updateUserInfoAsyncAwait(param: param)
    }
    
    func fake_fetch_sleeptime_and_update() async throws{
        
        let sleeptime:Double = 20600.0

        let param: [String:Any] = [
            "idToken": authManager.authToken,
            "sleep_time_yesterday": sleeptime
        ]
        
        healthManager.sleep_time_yesterday = sleeptime
        try await userData.updateUserInfoAsyncAwait(param: param)

    }
    
    
    func fetch_calories_burn_and_update(){

            healthManager.fetchCaloriesBurnYesterday{ calories, error in
                if let calories = calories {
                    
                    let param: [String:Any] = [
                        "idToken": authManager.authToken,
                        "calories_burn_yesterday": calories
                    ]
                    
                    
                    userData.updateUserInfo(param: param){result in
                        switch result {
                        case .success:
                            print("User information updated successfully!")
                        case .failure(let error):
                            print("Error updating user info: \(error.localizedDescription)")
                        }
                        
                    }
                    
                    print("Calories Burn for yesterday: \(calories)")
                  // Use the calories as needed
                } else if let error = error {
                  print("Error fetching calories: \(error)")
                  // Handle the error
                }
              }
    }
    
    func fetch_sleep_time_and_update(){
        healthManager.fetchSleepTimeYesterday{ sleepTime, error in
            
            if let sleepTime = sleepTime {
                
                let param: [String:Any] = [
                    "idToken": authManager.authToken,
                    "sleep_time_yesterday": sleepTime
                ]
                
                
                userData.updateUserInfo(param: param){result in
                    switch result {
                    case .success:
                        print("User information updated successfully!")
                    case .failure(let error):
                        print("Error updating user info: \(error.localizedDescription)")
                    }
                    
                }
                
                print("sleep_time_yesterday: \(sleepTime)")
              // Use the calories as needed
            } else if let error = error {
              print("Error fetching calories: \(error)")
              // Handle the error
            }
            
        }
    }

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

                    Text(userData.fullname)
                })
                .padding(40)

                VStack(alignment: .leading,spacing: 30, content: {
                    
                    HStack( content: {
                        HStack {
                            Text("Full Name:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }
                        TextField("Full Name", text: $userData.fullname)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                    
                    })
                    
                    HStack( content: {
                        HStack {
                            Text("Age:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }
                        TextField("Age", text: $userData.age)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                        Text("years old")
                            .foregroundColor(.secondary)
                    
                    })
                    
                    
                    HStack(content: {
                        HStack {
                            Text("Gender:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }
                        Picker("Gender", selection: $userData.selectedGenderIndex) {
                            ForEach(0..<2) { index in
                                Text(UserData.genders[index])
                                    .foregroundColor(Color.teal)

                            }
                        }
                    })
                    
                    HStack( content: {
                        HStack {
                            Text("Weight:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }
                        TextField("Weight", text: $userData.weight)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("lbs")
                            .foregroundColor(.secondary)
                    })
                    .frame(maxWidth: UIScreen.main.bounds.width)

                    
                    HStack(content: {
                        HStack {
                            Text("Height:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }
                        TextField("Height", text: $userData.height)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("ft")
                            .foregroundColor(.secondary)
                    })
                    .frame(maxWidth: UIScreen.main.bounds.width)

                            
                    HStack(content: {
                        HStack {
                            Text("Activity Level:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }

                        Section {
                            Picker("Activity Levels", selection: $userData.selectedActivityLvlIndex) {
                                ForEach(0..<3) { index in
                                    Text(UserData.activityLevels[index])
                                        .foregroundColor(Color.teal)
                                }
                            }
                        }
                    })
                    
                    HStack(content: {
                        HStack {
                            Text("Goal:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }
                        Section {
                            Picker("Goals", selection: $userData.selectedGoalIndex) {
                                ForEach(0..<3) { index in
                                    Text(UserData.goals[index])
                                        .foregroundColor(Color.teal)

                                }
                            }
                        }
                    })
                    
                    HStack( content: {
                        HStack {
                            Text("Target weight:")
                                .foregroundColor(.black)
                            Text("*")
                                .foregroundColor(.red)
                        }
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
                
                ProgressView() // Display the loading spinner
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(isLoading ? 1 : 0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button(action: {
                    showAlert = true

                }) {
                    Text("Save Profile")
                        .frame(maxWidth: .infinity)
//                        .foregroundColor(.teal)
                        .foregroundColor(userData.fullname.isEmpty || userData.age.isEmpty || userData.weight.isEmpty || userData.height.isEmpty || (userData.selectedGoalIndex != 2 && userData.target_weight.isEmpty) ? Color.gray : Color.teal)
                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                        .background(userData.fullname.isEmpty || userData.age.isEmpty || userData.weight.isEmpty || userData.height.isEmpty || (userData.selectedGoalIndex != 2 && userData.target_weight.isEmpty) ? RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray.opacity(0.2)) : RoundedRectangle(cornerRadius: 10).foregroundColor(Color.teal.opacity(0.2)))
                }
                .padding(20)
                .disabled(userData.fullname.isEmpty || userData.age.isEmpty || userData.weight.isEmpty || userData.height.isEmpty ||  (userData.selectedGoalIndex != 2 && userData.target_weight.isEmpty))
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Are you sure you want to save your changes?"),
                          primaryButton: .default(Text("Save"), action: {
                        if isFromSignUp == false {
                            isModalPresented = true
                            userData.saveProfile()
                        }
                        else{
                            print("sign up initialized")
                            Task{
                                isLoading = true
                                do{
                                    
                                    try await userData.saveProfileAsyncAwait()

                                    try await fetch_calories_burn_and_update()
                                    try await fetch_sleep_time_and_update()
                                    
                                    //try await fake_fetch_calories_burn_and_update()

                                    //try await fake_fetch_sleeptime_and_update()

                                    
                                    try await dietService.fetchBmiRec(idToken: authManager.authToken)
                                    try await dietService.getDietScore(idToken: authManager.authToken)
                                    try await sleepService.fetch_sleep_rec_point(idToken: authManager.authToken, sleep_time_yesterday: healthManager.sleep_time_yesterday)
                                    
                                    try await dietService.fetchRecipesAsyncAwait(idToken: authManager.authToken)
                                    
                                    try await exerciseService.fetchExerciseRecommendation(idToken: authManager.authToken)
                                    
                                    try await exerciseService.fetchExerciseScore(idToken: authManager.authToken)
                                    
                                    try await exerciseService.fetchExerciseDay(idToken: authManager.authToken)
                                    
                                    try await userData.getScoreForDay(idToken: authManager.authToken)
                                    
                                }
                                catch{
                                    
                                }
                                print("sign up initialized done")
                                isLoading = false
                                authManager.login()
                            }
                        }

                    }),
                          secondaryButton: .cancel()
                    )

                        }
                


                Spacer()
               
            })
            .padding()
        })
        .navigationBarBackButtonHidden(true)
        .disabled(isLoading)
    }
}

#Preview {
    UserInputs()
    .environmentObject(UserData())
    .environmentObject(DietService())
    .environmentObject(HealthkitManager())
    .environmentObject(SleepService())
    .environmentObject(ExerciseService())
    .environmentObject(LoginSignupService())
}
