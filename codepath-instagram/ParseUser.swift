//
//  ParseUser.swift
//  codepath-instagram
//
//  Created by Nisarga Patel on 3/13/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit
import Parse
class ParseUser: NSObject {
    
    var username: String?
    var password: String?
    
    // Constructor
    init(username: String, password: String){
        
        self.username = username ?? ""
        self.password = password ?? ""
    }
    
    // Function for logging in user
    func login(successCallback: () -> (), failureCallback: (NSError) -> ()){
        
        let username = self.username ?? ""
        let password = self.password ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                failureCallback(error)
            } else {
                
                successCallback()
                
            }
        }
        
    }
    
    // Function for registering a user
    func register(successCallback: () -> (), failureCallback: (NSError) -> ()){
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = self.username
        newUser.password = self.password
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                failureCallback(error)
            } else {
                
                successCallback()
            }
        }
        
        
    }
    

    
}
