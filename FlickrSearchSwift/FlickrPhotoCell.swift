//
//  FlickrPhotoCell.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import UIKit

class FlickrPhotoCell: UITableViewCell {
    @IBOutlet weak var flickrImageView: UIImageView!

    @IBOutlet weak var flickrTitleLabel: UILabel!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width / 2
        self.profilePhoto.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
