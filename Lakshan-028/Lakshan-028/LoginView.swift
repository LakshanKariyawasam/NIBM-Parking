//
//  LoginView.swift
//  Lakshan-028
//
//  Created by on 11/17/21.
//

import SwiftUI

struct LoginView: View {
    @State var email = "";
    @State var password = "" ;
    @ObservedObject var setting : AppSettings
    let controller = FirebaseController()
    
    var body: some View {
        VStack(alignment: .center){
            Text("Email")
                .font(.title)
            TextField("",text: $email)
                .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
            Text("Password")
                .font(.title)
                .padding(.top, 10.0)
            SecureField("",text: $password)
                .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
            
            Button(action:{
                controller.signIn(email: email, pass: password) {(success) in
                    setting.isLoggedIn = success
                }
                
            }, label:{
                Text("Login").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.756, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
            })
            .padding(.top, 20.0)
            
            Button(action:{
                setting.viewName = "Register"
            }, label:{
                Text("Register").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.647, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
            })
            .padding(.top, 30.0)
            
            
            Spacer()
            
            Button(action:{
                setting.viewName = "Password"
            }, label:{
                Text("Forget Password").fontWeight(.semibold).padding()
            })

            Button(action:{
                
            }, label:{
                Text("Terms & Conditions").fontWeight(.regular).padding()
            })

        }
        .padding(50.0).onAppear {
            
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
                                
               setting.isLoggedIn = true
            }
            
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
