//
//  PhotoDetailsController.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import UIKit

class PhotoDetailsController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photoImage: UIImage!
    var photoTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoImageView.image = self.photoImage
        self.photoImageView.contentMode = .ScaleAspectFit
        self.scrollView.clipsToBounds = true
        self.scrollView.zoomScale = 1.0
        self.scrollView.maximumZoomScale = 5.0
        self.scrollView.minimumZoomScale = 1.0
        
        let photoHeight = self.photoImage.size.height
        let photoWidth = self.photoImage.size.width
        
        if photoWidth < 1280 || photoHeight < 960 {
            self.scrollView.contentSize = CGSizeMake(1280, 960)
        } else {
            self.scrollView.contentSize = CGSizeMake(photoHeight, photoWidth)
        }
        
        self.scrollView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.photoImageView!
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
