//
//  RegisterView.swift
//  Lakshan-028
//
//  Created by on 11/18/21.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email = "";
    @State var password = "" ;
    @State var name = "" ;
    @State var nic = "" ;
    @State var vehiNo = "" ;
    @State var userType = "";
    @ObservedObject var setting : AppSettings
    @State private var showingAlert = false
    let controller = FirebaseController()
    @State private var alert: Message?;
    
 
    var body: some View {
        
        GeometryReader{ geometry in
            
            ScrollView(.vertical){
                VStack(alignment: .center){
                  
                    VStack{
                        Text("Email").font(.title)
                        TextField("",text: $email).keyboardType(.emailAddress)                    .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                        
                        Text("Password").font(.title)
                        SecureField("",text: $password)
                            .frame(width: 250.0, height: 30.0).background(Color(.secondarySystemBackground))
                    }.padding(.top, 20.0)
                    
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
                            var vip = email.contains("@admin.nibm.lk");
                            var normal = email.contains("@student.nibm.lk");
                            if(vip){
                                userType = "VIP";
                            }
                            if(normal){
                                userType = "NORMAL";
                            }
                            
                            if(!vip && !normal){
                                alert = Message(msg: "Invalid Email");
                                return;
                            }
                            if(password.isEmpty){
                                alert = Message(msg: "Please Enter Password");
                                return;
                            }
                            if(name.isEmpty){
                                alert = Message(msg: "Please Enter Name");
                                return;
                            }
                            if( nic.isEmpty){
                                alert = Message(msg: "Please Enter NIC");
                                return;
                            }
                            if(vehiNo.isEmpty){
                                alert = Message(msg: "Please Enter Vehicle No");
                                return;
                            }
                            
                            controller.createUser(email: email, password: password, name: name, vehno: vehiNo, nic: nic, type: userType) {(success) in
                                if(success){
                                    alert = Message(msg: "Succesfully Registered");
                                    setting.viewName = "Login"
                                }else{
                                    alert = Message(msg: "Registeration Failed");
                                }

                            }
                            
                            
                          }, label:{
                              Text("Register").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.756, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                          }).alert(item: $alert) { con in
                            Alert(title: Text(con.msg))
                        }
                          .padding(.top, 5.0)
                          
                          Button(action:{
                            setting.viewName = "Login"
                          }, label:{
                              Text("Login").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.647, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                          })
                          .padding(.top, 20.0)
                    }
                    
                }.frame(width: geometry.size.width)
            
        }
        

        }
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
