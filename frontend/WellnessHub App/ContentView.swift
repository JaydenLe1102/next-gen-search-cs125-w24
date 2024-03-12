//
//  ContentView.swift
//  WellnessHub App
//
//  Created by BobaHolic on 2/5/24.
//

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var dietService: DietService
    @EnvironmentObject var healthManager: HealthkitManager
    @EnvironmentObject var sleepService: SleepService
    
    
    @StateObject private var authManager = AuthenticationManager.shared
    
    //view properties
    @State private var showSignUp: Bool = false
//    @State private var showHome: Bool = false
//    @State private var isLoggedIn = authManager.isAuthenticated
    @State private var selectedTab = 1
    
    @State private var isLoggedIn = true
    
    @State private var isWeightModalPresented = false
    @State private var currentWeight = ""
    @State private var isLoading = false
    
    
    
    func fake_fetch_calories_burn_and_update(){
        
        let calories = 609.9019999999992

        let param: [String:Any] = [
            "idToken": authManager.authToken,
            "calories_burn_yesterday": calories
        ]
        
        healthManager.calories_burn_yesterday = calories
        
        userData.updateUserInfo(param: param){result in
            switch result {
            case .success:
                print("User information updated successfully!")
            case .failure(let error):
                print("Error updating user info: \(error.localizedDescription)")
            }
            
        }

    }
    
    func fake_fetch_sleeptime_and_update(){
        
        let sleeptime:Double = 20600.0

        let param: [String:Any] = [
            "idToken": authManager.authToken,
            "sleep_time_yesterday": sleeptime
        ]
        
        healthManager.sleep_time_yesterday = sleeptime
        userData.updateUserInfo(param: param){result in
            switch result {
            case .success:
                print("User information updated successfully!")
            case .failure(let error):
                print("Error updating user info: \(error.localizedDescription)")
            }
            
        }

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
        
        if authManager.isAuthenticated {
            VStack{
                ProgressView() // Display the loading spinner
                        .progressViewStyle(CircularProgressViewStyle())
                        .opacity(isLoading ? 1 : 0)
                
                TabView(selection: $selectedTab) {
                    
                    Home(userData: userData).tag(1)
                    
                    Diet().tag(2)
                    
                    Exercises().tag(3)
                    
                    Sleep().tag(4)
                        .navigationBarHidden(true)
                    
                    Profile().tag(5)
                        .navigationBarHidden(true)
                    
                }
                .overlay(alignment: .bottom, content: {
                    CustomTabView(selectedTab: $selectedTab)
                        .background(.white)
                        .overlay(
                            Rectangle()
                                .frame(height: 0.35)
                                .foregroundColor(.gray)
                                .offset(y: -39)
                                .edgesIgnoringSafeArea(.top)
                        )
                })
                .overlay(alignment: .center, content: {
                    CustomInputModal(isWeightModalPresented: $isWeightModalPresented, currentWeight: .constant("150"))
                        .opacity(isWeightModalPresented ? 1 : 0)
                })
                

            }
            .disabled(isLoading)
            .onAppear{
                
                        Task{
                            do{
//                                try await userData.fetch_and_update(idToken: authManager.authToken)
//                                try await dietService.getDietScore(idToken: authManager.authToken)
//                                try await sleepService.fetch_sleep_rec_point(idToken: authManager.authToken)
//                                
//                                try await dietService.fetchRecipesAsyncAwait(idToken: authManager.authToken)
//                                
//                                try await userData.getScoreForDay(idToken: authManager.authToken)
                                
//                                try await userData.getScoreForWeek()
                                
                                let date = userData.get_last_update_weight_date()
                                
                                
                                let today = Date()
                               
                                if (date == nil){ // 7 days  = 10080 mins
                                    isWeightModalPresented = true
                                }
                                else {
                                    let diffMinutes  = today.timeIntervalSince(date!) / 60.0
                                    if (diffMinutes > 10080){
                                        isWeightModalPresented = true
                                    }
                                }
                                
                                if (healthManager.calories_burn_yesterday == 0){
//                                    fetch_calories_burn_and_update()
                                    fake_fetch_calories_burn_and_update()
                                }
                                
        //                        fetch_sleep_time_and_update()
                                if (healthManager.sleep_time_yesterday == 0){
//                                    fetch_sleep_time_and_update()
                                    fake_fetch_sleeptime_and_update()
                                }
                            }
                            catch{
                                
                            }
   
                    }
                    
                }
            }
        
            
        else {
            NavigationStack {
                LogIn(showSignUp: $showSignUp, selectedTab: $selectedTab)
                    .navigationDestination(isPresented: $showSignUp) {
                        SignUp(showSignUp: $showSignUp, selectedTab: $selectedTab)
                    }
                    .onAppear {
                        Task{

                            do {
//                                fetch_calories_burn_and_update()
//                                fetch_sleep_time_and_update()
                                fake_fetch_calories_burn_and_update()
                                fake_fetch_sleeptime_and_update()
                            } catch {
                                print("Error fetching healthkit:", error)
                            }
                        }
                    }

            }
            .background(Color(.systemBackground))
        }
    }
}

//#Preview {
//    ContentView()
//        .environmentObject(UserData(healthKitManager: HealthkitManager()))
//        .environmentObject(DietService())
//        .environmentObject(HealthkitManager())
//}
