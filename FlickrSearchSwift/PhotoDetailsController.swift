//
//  PhotoDetailsController.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import UIKit

class PhotoDetailsController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photoImageView: UIImageView!
    var photoImage: UIImage!
    var photoTitle: String!
    
    var userName: String!
    var userProfile: UIImage!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        photoLabel.text = photoTitle
        usernameLabel.text = userName
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        profileImage.image = userProfile
        
        photoImageView = UIImageView(image: photoImage)
        
        scrollView.contentSize = photoImageView.bounds.size
        scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        scrollView.contentOffset = CGPoint(x: 1000, y: 450)
        
        scrollView.addSubview(photoImageView)
        
        setZoomScale()
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ScrollView Method
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let imageViewSize = photoImageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    func setZoomScale() {
        let imageViewSize = photoImageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
}
