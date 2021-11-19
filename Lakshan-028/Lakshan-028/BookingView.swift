//
//  BookingView.swift
//  Lakshan-028
//
//  Created by on 11/16/21.
//

import SwiftUI
import CodeScanner

struct BookingView: View {
    @State var regNo = "";
    @State var vehiNo = "";
    @State var userObj: [String: Any] = ["":""];
    @State var time = "";
    
    @State var selectedTime = 0
    @State var isPresentingScanner = false;
    @State var qrCode: String = "";
    @State var avaSolts: [String] = [];
    @State private var avaSoltsIndex = 0;
    @ObservedObject var setting : AppSettings
   
    
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
                    Text(regNo)
                        .fontWeight(.semibold)
                    Text(vehiNo)
                        .fontWeight(.semibold)
                }
                
            }.shadow(radius: 10 )
            .padding(.all, 20.0).foregroundColor(.black).background(Color(hue: 0.547, saturation: 0.34, brightness: 0.969)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
            
            
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
                
                Picker("Picker",selection: $selectedTime, content:{
                    Text("30 Minutes").tag(0)
                    Text("1 Hour").tag(1)
                    Text("2 Hour").tag(2)
                    Text("3 Hour").tag(3)
                }).frame(height: 100.0)
                
                Button(action:{
                    self.getTime()
                    let controller = FirebaseController()
                    controller.booking(slotId: avaSolts[avaSoltsIndex], userObj: userObj, time: time) {(success) in
                        if(success){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.loadData();
                            }
                        }else{

                        }

                    }
                }, label:{
                    Text("Book Now").fontWeight(.semibold).foregroundColor(.white).padding().frame(width: 200.0, height: 30.0).background(Color(hue: 0.647, saturation: 1.0, brightness: 0.992)).cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
                })
                
                .padding(.top, 50.0)
            }
            
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
            
            
        }.padding(20.0).onAppear {
           // if(!isLoaded){
            self.getUserData()
            self.loadData();
                //self.isLoaded = true;
            //}
        
        
        }
            
        
    }
    
    func loadData(){
       // self.avaSolts = [];
        let controller = FirebaseController()
        controller.getAvailableSlots() {(success) in
            self.avaSolts = success;
        }
    }
    
    func getUserData(){
        let controller = FirebaseController()
        controller.getUser() {(success) -> Void in
           let regId = success["regid"] as! Int64;
            if(regId==0){
               setting.isLoggedIn = false
            }else{
                self.userObj = success
                self.regNo = String(regId);
                self.vehiNo = success["vehicleNo"] as! String
                
               setting.isLoggedIn = true
            }
            
        }
    }
    
    
    func getTime(){
        var date = NSDate();
        if(self.selectedTime == 0){
            date = date.addingTimeInterval((TimeInterval(30.0 * 60.0)))
        }else if(self.selectedTime == 1){
            date = date.addingTimeInterval((TimeInterval(60.0 * 60.0)))
        }else if(self.selectedTime == 2){
            date = date.addingTimeInterval((TimeInterval(120.0 * 60.0)))
        }else if(self.selectedTime == 3){
            date = date.addingTimeInterval((TimeInterval(180.0 * 60.0)))
        }else {
            
        }
       
        let calender = Calendar.current;
        let hour = calender.component(.hour, from: date as Date)
        let min = calender.component(.minute, from: date as Date)

        time = "\(hour)"+":"+"\(min)"
        
        time = "\(String(format: "%02d", hour)):\(String(format: "%02d", min))"
       
    }
}

//struct BookingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingView(, setting: AppSettings)
//            .preferredColorScheme(.light)
//    }
//}
