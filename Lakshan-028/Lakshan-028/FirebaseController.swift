//
//  FirebaseController.swift
//  Lakshan-028
//
//  Created by on 11/17/21.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseController{
    
    var avaSlots :[String] = []
    
    func getAllSlots(completionBlock: @escaping (_ success: [DataSnapshot]) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("datas").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.children.allObjects as! [DataSnapshot]
            completionBlock(data)
            })
    }
    
    
    func getAvailableSlots(type:String,completionBlock: @escaping (_ success: [String]) -> Void) {
        self.avaSlots = [];
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let dataset = ref.child("datas").queryOrdered(byChild: "status").queryEqual(toValue : "AVAILABLE")

        dataset.observe(.value, with:{ (snapshot) in
            for snap in snapshot.children {
                
                if(type=="VIP"){
                    self.avaSlots.append((snap as! DataSnapshot).key)
                }else{
                   let element = (snap as! DataSnapshot).value as! [String: Any]
                    
                    let sType = element["type"] as! String;
                    if(sType=="NORMAL"){
                        self.avaSlots.append((snap as! DataSnapshot).key)
                    }
                }
                
            }
            //print(self.avaSlots)
            completionBlock(self.avaSlots);
        })        
    }
    
    func getUser(completionBlock: @escaping (_ success: [String: Any]) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else {
            completionBlock(["regid" : 0 as Int64]);
            return
            
        }
        
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                           
            let userObj = snapshot.value as! [String: Any]
            completionBlock(userObj);
        })
    }
    
    
    func createUser(email: String, password: String,name:String,vehno:String,nic:String,type:String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                let id=Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
                let userData = ["regid":id,
                                "name":name,
                                "vehicleNo":vehno,
                                "isBlocked":false,
                                "uType":type,
                                "nic":nic] as [String : Any]
                
                var ref: DatabaseReference!

                ref = Database.database().reference()
                
                ref.child("users").child(user.uid).setValue(userData)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func forgetPassword(email: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func logOut(){
        try! Auth.auth().signOut();
    }
    
    func booking(slotId: String,userObj: Any,time: String, bookedTime: String, lon: Double,lati: Double, completionBlock: @escaping (_ success: Bool) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("datas").child(slotId).child("user").setValue(userObj)
        ref.child("datas").child(slotId).child("dateTime").setValue(time)
        ref.child("datas").child(slotId).child("bookedTime").setValue(bookedTime)
        ref.child("datas").child(slotId).child("lastLati").setValue(lati)
        ref.child("datas").child(slotId).child("lastLong").setValue(lon)
        let prntRef = ref.child("datas").child(slotId)
        prntRef.updateChildValues(["status":"BOOKED"])
        completionBlock(true)
        
    }
    
    func bookingUpdateLoc(slotId: String, lon: Double,lati: Double, completionBlock: @escaping (_ success: Bool) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("datas").child(slotId).child("lastLati").setValue(lati)
        ref.child("datas").child(slotId).child("lastLong").setValue(lon)
        let prntRef = ref.child("datas").child(slotId)
        prntRef.updateChildValues(["status":"BOOKED"])
        completionBlock(true)
    }
    
    func getNibmLocation(completionBlock: @escaping (_ success: [String: Any]) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
     
        
        ref.child("nibm").child("location").observeSingleEvent(of: .value, with: { (snapshot) in
            let userObj = snapshot.value as! [String: Any]
            completionBlock(userObj);
        })
    }
    
}
