//
//  ContentView.swift
//  Lakshan-028
//
//  Created by on 11/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var setting = AppSettings()
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            if(setting.isLoggedIn){
                BookingView(setting: setting)
                        .tabItem {
                            Image(systemName: "book")
                            Text("Booking")
                    }
                SettingsView(setting: setting).tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }else{
                if(setting.viewName=="Login"){
                    LoginView(setting: setting)
                            .tabItem {
                                Image(systemName: "person")
                                Text("Login")
                        }
                }else if(setting.viewName=="Register"){
                    RegisterView(setting: setting)
                            .tabItem {
                                Image(systemName: "person")
                                Text("Register")
                            }
                    
                }else if(setting.viewName=="Password"){
                    ForgetPasswordView(setting: setting)
                            .tabItem {
                                Image(systemName: "person")
                                Text("Password Reset")
                            }
                }
            }
        }.onAppear {
         
             //self.getUserData()
             
         
         }
    }
    
    func getUserData(){
        let controller = FirebaseController()
        controller.getUser() {(success) -> Void in
           let regId = success["regid"] as! Int64;
            if(regId==0){
               setting.isLoggedIn = false
            }else{
                                
               setting.isLoggedIn = true
            }
            
        }
    }
}

class AppSettings: ObservableObject{
    @Published var isLoggedIn = false;
    @Published var viewName = "Login"
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
