//
//  FirebaseController.swift
//  Lakshan-028
//
//  Created by Mobios on 11/17/21.
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
    
    
    func getAvailableSlots(completionBlock: @escaping (_ success: [String]) -> Void) {
        self.avaSlots = [];
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let dataset = ref.child("datas").queryOrdered(byChild: "status").queryEqual(toValue : "AVAILABLE")

        dataset.observe(.value, with:{ (snapshot) in
            for snap in snapshot.children {
                //print((snap as! DataSnapshot).key)
                self.avaSlots.append((snap as! DataSnapshot).key)
            }
            //print(self.avaSlots)
            completionBlock(self.avaSlots);
        })        
    }
    
    func getUser(completionBlock: @escaping (_ success: [String: Any]) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        print("mehe awsssa")
        guard let userID = Auth.auth().currentUser?.uid else {
            completionBlock(["regid" : 0 as Int64]);
            return
            
        }
        
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
            print("mehe awa")
            let userObj = snapshot.value as! [String: Any]
            completionBlock(userObj);
        })
    }
    
    
    func createUser(email: String, password: String,name:String,vehno:String,nic:String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                let id=Int64((Date().timeIntervalSince1970 * 1000.0).rounded())
                let userData = ["regid":id,
                                "name":name,
                                "vehicleNo":vehno,
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

}
