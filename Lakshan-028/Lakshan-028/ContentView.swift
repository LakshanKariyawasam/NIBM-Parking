//
//  ContentView.swift
//  Lakshan-028
//
//  Created by on 11/15/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var setting = AppSettings()
    @State var selection = 1
    
    
    var body: some View {
        
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(1)
            
            if(setting.isLoggedIn){
                BookingView(setting: setting)
                        .tabItem {
                            Image(systemName: "book")
                            Text("Booking")
                    }.tag(2)
                SettingsView(setting: setting).tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }.tag(3)
            }else{
                if(setting.viewName=="Login"){
                    LoginView(setting: setting)
                            .tabItem {
                                Image(systemName: "person")
                                Text("Login")
                        }.tag(4)
                }else if(setting.viewName=="Register"){
                    RegisterView(setting: setting)
                            .tabItem {
                                Image(systemName: "person")
                                Text("Register")
                            }.tag(5)
                    
                }else if(setting.viewName=="Password"){
                    ForgetPasswordView(setting: setting)
                            .tabItem {
                                Image(systemName: "person")
                                Text("Password Reset")
                            }.tag(1)
                }
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
