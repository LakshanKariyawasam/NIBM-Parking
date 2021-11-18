//
//  LoginView.swift
//  Lakshan-028
//
//  Created by Mobios on 11/17/21.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var setting : AppSettings   
    
    var body: some View {
        VStack(alignment: .leading){
            Button("Scan QR"){
                setting.isLoggedIn = true
            }.padding(5)
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
