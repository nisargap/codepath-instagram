//
//  LoginViewController.swift
//  codepath-instagram
//
//  Created by Nisarga Patel on 3/13/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    var user: ParseUser?
    // Outlets for username and password text
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBAction func loginAction(sender: AnyObject) {
        
        self.user = ParseUser(username: usernameText.text!, password: passwordText.text!)
        self.user?.login({ () -> () in
            
            // segue to next view
            print("Logged in successfully!")
            self.performSegueWithIdentifier("HomeSegue", sender: nil)
            
            }, failureCallback: { (error: NSError) -> () in
                
                self.alertBox("Error", message: "Could not login! Please check your credentials.")
                print(error.localizedDescription)
        
        })
        
    }
    func alertBox(title: String, message: String){
        // alert that the user got an error trying to sign up
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    @IBAction func signupAction(sender: AnyObject) {
        
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameText.text
        newUser.password = passwordText.text
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                if error.code == 202 {
                    self.alertBox("User exists", message: "Choose a different username")
                }else {
                    self.alertBox("Error", message: "Is your internet working?")
                }
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
