//
//  DBService.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Foundation
import FirebaseDatabase


class DBService: NSObject {
    
    private override init() {
        
        rootRef = Database.database().reference()
        usersRef = rootRef.child("users")
        whimsRef = rootRef.child("whims")
        super.init()
        
    }
    
    static let manager = DBService()
        
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var whimsRef: DatabaseReference!
 
    
    
    public func addImage(url: String, ref: DatabaseReference, id: String) {
        ref.child(id).child("photoID").setValue(url)
        
    }
    
    
    // Create a Whim by current user
    
    public func addWhim(withCategory category: String, title: String, description: String, location: String, duration: Int) {
        
//        guard let currentUser = AuthUserService.manager.getCurrentUser() else {
//            print("Error: could not get current user id, please exit the app and log back in.")
//            return
//        }
        
        let ref = whimsRef.childByAutoId()
//        let whim = Whim(id: ref.key, category: category, title: title, description: description, hostID: currentUser.uid, location: location, duration: duration)
let whim = Whim(id: ref.key, category: category, title: title, description: description, hostID: "testhostid", location: location, duration: duration)
        
        
        
        
        
        
        
        /// REPLACE CURRENT USER UID WITH FACEBOOK ID WHEN AVAILABLE
        /// create a whim button crashes.
        
        
        
        
        
        
        
        ref.setValue(["id": whim.id,
                      "category": whim.category,
                      "title": whim.title,
                      "description": whim.description,
                      "hostID": whim.hostID,
                      "location": whim.location,
                      "duration": whim.duration,
                      "finalized": whim.finalized,
                      "timestamp": whim.timestamp
            ]) { (error, _) in
            if let error = error {
                print("error saving Whim: \(error.localizedDescription)")
            } else {
                print("new Whim added to database!")
            }
        }
    
    }
    
    
}











