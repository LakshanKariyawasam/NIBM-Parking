//
//  SettingsView.swift
//  Lakshan-028
//
//  Created by on 11/16/21.
//

import SwiftUI

struct SettingsView: View {
    @State var regNo = "";
    @State var name = "" ;
    @State var nic = "" ;
    @State var vehiNo = "" ;
    let controller = FirebaseController()
    @ObservedObject var setting : AppSettings
    @ObservedObject var location = LocationManager();
    
    var body: some View {
        VStack{
            HStack( spacing: 50){
                VStack(alignment: .leading){
                    Text("Name")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 15.0)
                    Text("NIC")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30.0)
                    Text("Reg No")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30.0)
                    Text("Vehicle No")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 30.0)
                }
                
                VStack(alignment: .leading){
                    Text(name)
                        .fontWeight(.semibold)
                        .padding(.top, 15.0)
                    Text(nic)
                        .fontWeight(.semibold)
                        .padding(.top, 30.0)
                    Text(regNo)
                        .fontWeight(.semibold)
                        .padding(.top, 30.0)
                    Text(vehiNo)
                        .fontWeight(.semibold)
                        .padding(.top, 30.0)
                }
                
            }.shadow(radius: 10 )
            .padding([.leading, .bottom, .trailing], 20.0).foregroundColor(.black).background(Color(hue: 0.547, saturation: 0.34, brightness: 0.969)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            Button(action:{
                controller.logOut();
                setting.isLoggedIn = false
            }, label:{
                Text("Logout").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.647, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
            })
            .padding(.vertical, 30.0)

        }.padding(.top, 20.0).onAppear(){
            self.getUserData()
        }
       
        
    }
    
    func getUserData(){
        let controller = FirebaseController()
        controller.getUser() {(success) -> Void in
           let regId = success["regid"] as! Int64;
            if(regId==0){
               setting.isLoggedIn = false                
            }else{
                self.regNo = String(regId);
                self.name = success["name"] as! String;
                self.vehiNo = success["vehicleNo"] as! String
                self.nic = success["nic"] as! String
                
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
