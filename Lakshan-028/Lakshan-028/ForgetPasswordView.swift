//
//  ForgetPasswordView.swift
//  Lakshan-028
//
//  Created by Mobios on 11/18/21.
//

import SwiftUI

struct ForgetPasswordView: View {
    @State var email = "";
    @State private var showingAlert = false
    let controller = FirebaseController()
    @ObservedObject var setting : AppSettings
    
    var body: some View {
        VStack(alignment: .center){
            Text("Email")
                .font(.title)
            TextField("",text: $email)
                .frame(width: 250.0, height: 40.0).background(Color(.secondarySystemBackground))
            
            VStack{
                   
                  Button(action:{
                    
                    controller.forgetPassword(email: email) {(success) in
                        if(success){
                            self.showingAlert = true
                            setting.viewName = "Login"
                            
                            
                        }else{
                            
                        }
                    }
                        
                  }, label:{
                      Text("Submit").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 50.0).background(Color(hue: 0.756, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                  }).alert(isPresented: self.$showingAlert) {
                    Alert(title: Text("Success"))
                }
                  .padding(.top, 5.0)
                
                  
                  Button(action:{
                    setting.viewName = "Login"
                  }, label:{
                    Text("Go Back").font(.title).fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 150.0, height: 30.0).background(Color(hue: 0.647, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                  })
                  .padding(.top, 80.0)
            }
            
        }
        
    }
    
}

//struct ForgetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgetPasswordView()
//    }
//}
