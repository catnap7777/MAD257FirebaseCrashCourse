//
//  ViewController.swift
//  MAD257FirebaseCrashCourse
//
//  Created by Karen Mathes on 2/15/21.
//  Copyright © 2021 TygerMatrix Software. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //.. firebase database structure for this example is..
        //  - someid (or at this level can be randomly auto-generated key - see below)
        //      |_ age:39
        //      |_ name: Tori
        //      |_ role: Admin
        //
        
        let ref = Database.database().reference()
        
        //..........................................................................
        //.. to set particular value
        //ref.child("someid/name").setValue("Tori")
        
        //.. to insert new "row" (key/value) - auto-generating new unique key
        //ref.childByAutoId().setValue(["name":"Tom", "role":"Admin", "age":30])
        
        //..........................................................................
        //.. to read one key/value pair
        ref.child("someid/name").observeSingleEvent(of: .value)
        { (snapshot) in
            let name = snapshot.value as? String
            print("*** name = \(name)")
        }
        
        //.. to read multiple key/value pairs - use dictionary to hold data
        ref.child("someid").observeSingleEvent(of: .value)
        { (snapshot) in
            let data = snapshot.value as? [String: Any]
            print("*** data = \(data)")
        }
        
        //..........................................................................
        //.. to update a single value, use setValue
        ref.child("someid/name").setValue("John")
        
        //.. to update multiple values at the same time, use updateChildRef and pass in a dictionary
        //..  Note: key for David is the previously auto-generated id that's already out on the firebase console
        let updates = ["someid/name":"John", "-MTg3Q8lNs_FCxeAOWnP":"David"]
        ref.updateChildValues(updates)
        
        //..........................................................................
        //.. to delete data
        ref.child("someid2").removeValue()
        //.. to put back the "row" that was just deleted
        //.. to set particular value
        ref.child("someid2").setValue(["name":"Ella", "role":"Princess", "age":21])
        //..  or to generate by auto-id
        //ref.childByAutoId().setValue(["name":"Ella, "role":"Princess", "age":20])
        
    }


}

