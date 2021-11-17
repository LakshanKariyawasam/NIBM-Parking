//
//  BookingView.swift
//  Lakshan-028
//
//  Created by on 11/16/21.
//

import SwiftUI
import CodeScanner

struct BookingView: View {
    @State var isPresentingScanner = false;
    @State var qrCode: String = "";
    @State var avaSolts: [String] = [];
    @State private var avaSoltsIndex = 1;
    @State var isLoggedIn = false;
    
    var scannerSheet : some View{
        CodeScannerView(
            codeTypes: [.qr],
            completion: {res in
                if case let .success(code) = res{
                    self.qrCode = code;
                    self.isPresentingScanner = false
                }
            
            }
        )
    }
    
    
    var body: some View {
        VStack{
            HStack( spacing: 100){
                VStack(alignment: .leading){
                    Text("Reg No")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Text("Vehicle No")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                }
                
                VStack(alignment: .leading){
                    Text("135555")
                        .fontWeight(.semibold)
                    Text("BBC-4762")
                        .fontWeight(.semibold)
                }
                
            }.shadow(radius: 10 )
            .padding(.bottom, 20.0).foregroundColor(.black).background(Color(hue: 0.547, saturation: 0.34, brightness: 0.969))
            
            
            VStack{
                Text("Select Slot")
                    .padding(.trailing, 80.0)
                    
                HStack{
                    Picker(selection: $avaSoltsIndex,label: Text("Picker")) {
                        ForEach(0..<avaSolts.count, id: \.self) { index in
                            Text("\(self.avaSolts[index])")
                                        
                          }
                    }
                    .frame(height: 100.0)
                    
                    Button("Scan QR"){
                        self.isPresentingScanner = true;
                    }.padding(5)
                    
                }
                
            }
            
            VStack{
                Text("Select Time")
                
                    Picker(selection: .constant(1), label: Text("Picker")) {
                        Text("30 Minutes").tag(1)
                        Text("1 Hour").tag(2)
                        Text("2 Hour").tag(3)
                        Text("3 Hour").tag(4)
                    }
                    .frame(height: 100.0)
                
                Button("Book Now"){
                    
                }
                .padding(.top, 50.0)
            }
            
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }
        .padding(20.0).onAppear {
           // if(!isLoaded){
                self.loadData();
                //self.isLoaded = true;
            //}
        
        }
    }
    
    func loadData(){
        let controller = FirebaseController()
        
        controller.getAvailableSlots() {(success) in
            self.avaSolts = success;
            print(success)
        }
        
        controller.getUser() {(success) -> Void in
           let regId = success["regid"] as! Int64;
            if(regId==0){
                print("not login")
                self.isLoggedIn = false;
                
            }else{
                self.isLoggedIn = true;
            }
            
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
            .preferredColorScheme(.light)
    }
}
