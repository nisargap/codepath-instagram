//
//  PostCell.swift
//  codepath-instagram
//
//  Created by Nisarga Patel on 3/13/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var postImage: PFImageView!
    
    @IBOutlet weak var postCaption: UILabel!
    
    var postObj : PFObject! {
    
        didSet {
            self.postImage.file = postObj["media"] as? PFFile
            self.postImage.loadInBackground()
            self.postCaption.text = postObj["caption"] as! String!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
