//
//  CollectionCellView.swift
//  Lakshan-028
//
//  Created by on 11/16/21.
//

import SwiftUI
import FirebaseDatabase

struct CollectionCellView: View {
    
    var data : DataSnapshot
    
    var body: some View {
        let type = self.data.childSnapshot(forPath: "type").value as! String;
        let status = self.data.childSnapshot(forPath: "status").value as! String;
        let slotName = self.data.childSnapshot(forPath: "name").value as! String;
        
        let backColor = type == "VIP" ? Color("vipBackColor") : Color("norBackColor");
        let backBorderColor = type == "VIP" ? Color("vipBorderColor") : Color("norBorderColor");
        let textbackcolor = type == "VIP" ? Color("vipTextBackcolor") : Color("norTextBackcolor");
        
        let time = self.data.childSnapshot(forPath: "dateTime").value as! String;
        
        VStack(){
            
            Text(type).fontWeight(.semibold)
                .padding([.top, .leading, .trailing], 3.0).foregroundColor(Color.white).background(textbackcolor)
            
            Text(slotName)
            
            Text(status).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            if(status=="BOOKED"){
                let user = self.data.childSnapshot(forPath: "user").value as! [String:Any]
                Text(user["vehicleNo"] as! String)
                    .fontWeight(.light)
                Text(timeDiff(fTime: time)).fontWeight(.light).padding([.leading, .bottom, .trailing], 3.0).font(.system(size: 15))
            }else{
                
            }

            
                
        }
        .frame(width: 120.0,height: 120.0)
        .background( backColor)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(backBorderColor, lineWidth: 4)).shadow(radius: 10 )
    }
    
    func timeDiff(fTime fromTime:String) -> String{
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"

        let date1 = dateFormatter.date(from: fromTime)!

            let date2 = NSDate()

        var components1 = NSCalendar.current.dateComponents([.hour, .minute], from: date1)

            let components2 = NSCalendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: date2 as Date)

            components1.year = components2.year;
            components1.month = components2.month;
            components1.day = components2.day;

            let date3 = NSCalendar.current.date(from: components1)

           // let timeIntervalInMinutes = date3!.timeIntervalSince(date2 as Date)/60
       
        let elapsedTime = date3!.timeIntervalSince(date2 as Date)
        let hours = floor(elapsedTime / 60 / 60)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
            return "Rem. \(Int(hours)) H \(Int(minutes)) M"
    }
}

//struct CollectionCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionCellView()
//    }
//}


