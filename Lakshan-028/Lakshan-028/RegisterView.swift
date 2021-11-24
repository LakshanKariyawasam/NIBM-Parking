//
//  RegisterView.swift
//  Lakshan-028
//
//  Created by Mobios on 11/18/21.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email = "";
    @State var password = "" ;
    @State var name = "" ;
    @State var nic = "" ;
    @State var vehiNo = "" ;
    @ObservedObject var setting : AppSettings
    @State private var showingAlert = false
    let controller = FirebaseController()
    
    
    var body: some View {
        
        VStack(alignment: .center){
          
            VStack{
                Text("Email").font(.title)
                TextField("",text: $email)
                    .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                
                Text("Password").font(.title)
                SecureField("",text: $password)
                    .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
            }
            
            Text("Name").font(.title)
            TextField("",text: $name)
                .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
            
            Text("NIC").font(.title)
            TextField("",text: $nic)
                .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
            
            Text("VehicleNo").font(.title)
            TextField("",text: $vehiNo)
                .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
            VStack{
                   
                  Button(action:{
                    controller.createUser(email: email, password: password, name: name, vehno: vehiNo, nic: nic) {(success) in
                        if(success){
                            self.showingAlert = true;
                            setting.viewName = "Login"
                        }else{
                            
                        }
                        
                    }
                  }, label:{
                      Text("Register").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.756, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                  }).alert(isPresented: self.$showingAlert) {
                    Alert(title: Text("Succesfully Registered"))
                  }
                  .padding(.top, 5.0)
                  
                  Button(action:{
                    setting.viewName = "Login"
                  }, label:{
                      Text("Login").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.647, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                  })
                  .padding(.top, 5.0)
            }

        }
        
        
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
