//
//  CaptureViewController.swift
//  codepath-instagram
//
//  Created by Nisarga Patel on 3/13/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var postImage : UIImage?
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    @IBOutlet weak var captionText: UITextField!
    @IBAction func postImage(sender: AnyObject) {
        
        let smaller_image = resize(postImage!, newSize: CGSize(width: 200, height: 200))
        
        Post.postUserImage(smaller_image, withCaption: captionText.text) { (success: Bool, error: NSError?) -> Void in
            
            if let error = error {
                print(error.localizedDescription)
            }else{
                self.performSegueWithIdentifier("BackToHome", sender: nil)
            }
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func onImageViewTap(sender: AnyObject) {
        print("You tapped?")
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            vc.sourceType = UIImagePickerControllerSourceType.Camera
        }else {
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let newImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            imageView.image = nil
            imageView.image = newImage
            self.postImage = newImage
            
            // Do something with the images (based on your use case)
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
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
