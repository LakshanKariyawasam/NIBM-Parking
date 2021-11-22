//
//  FirebaseController.swift
//  Lakshan-028
//
//  Created by Mobios on 11/17/21.
//

import Foundation
import FirebaseDatabase

class FirebaseController{
    
    func getAllSlots(completionBlock: @escaping (_ success: [DataSnapshot]) -> Void) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("datas").observeSingleEvent(of: .value, with: { (snapshot) in
            let data = snapshot.children.allObjects as! [DataSnapshot]
            completionBlock(data)
            })
    }

}
