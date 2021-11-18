//
//  SettingsView.swift
//  Lakshan-028
//
//  Created by on 11/16/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var setting : AppSettings
   

    var body: some View {
        VStack{
            Text("Hello, Settings!")
            
            Button("Scan QR"){
                setting.isLoggedIn = true
            }.padding(5)
        }.onAppear(){
            self.getUserData()
        }
       
        
    }
    
    func getUserData(){
        let controller = FirebaseController()
        controller.getUser() {(success) -> Void in
           let regId = success["regid"] as! Int64;
            if(regId==0){
                print("not login")
                setting.isLoggedIn = false
                
            }else{
                setting.isLoggedIn = true
            }
            
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
