//
//  HomeViewController.swift
//  codepath-instagram
//
//  Created by Nisarga Patel on 3/13/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var posts: [PFObject]!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onCapture(sender: AnyObject) {
        performSegueWithIdentifier("CaptureSegue", sender: nil)
    }
    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
        performSegueWithIdentifier("LogoutSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts
                self.tableView.reloadData()
            } else {
                // handle error
            }
        }
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts != nil {
            return posts.count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        cell.postObj = self.posts[indexPath.row]
        
        return cell
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
