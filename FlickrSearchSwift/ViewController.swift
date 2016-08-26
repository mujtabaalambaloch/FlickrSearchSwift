//
//  ViewController.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import UIKit
import MBProgressHUD
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ViewModel()
    var page = 1
    var searchString: String?
    var messageLabel = UILabel?()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTextField.layer.cornerRadius = 2.0
        self.searchButton.layer.cornerRadius = 2.0
        
        tableView.delegate = self
        tableView.dataSource = self
        self.viewModel.setupArr()
        
        self.tableView.estimatedRowHeight = 215
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.emptyTable()
        //self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Search Action
    @IBAction func searchFlickr(sender: AnyObject) {
        searchTextField.resignFirstResponder()
        if searchTextField.text?.isEmpty == false {
            self.viewModel.setupArr()
            self.messageLabel!.text = ""
            self.searchString = searchTextField.text!
            self.callAPI(searchTextField.text!, pageNum: 1)
        }
    }
    
    // MARK: API Call
    func callAPI(text:String, pageNum:Int) -> Void {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.viewModel.apiCall(text, page: pageNum) { (success) in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if self.viewModel.numberOfRow() <= 0 {
                self.messageLabel!.text = "No Data Found\nPlease Try Search Again"
            }
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: Empty Table
    
    func emptyTable() {
        messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        messageLabel!.text = "Please Try Search\nTo Find Images"
        messageLabel!.textColor = UIColor.lightGrayColor()
        messageLabel!.numberOfLines = 0
        messageLabel!.textAlignment = .Center
        messageLabel!.font = UIFont.systemFontOfSize(18)
        messageLabel!.sizeToFit()
        self.tableView.backgroundView = messageLabel
    }
    
    // MARK: TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FlickrPhotoCell = self.tableView.dequeueReusableCellWithIdentifier("Cell")! as! FlickrPhotoCell
        cell.flickrImageView.sd_setImageWithURL(viewModel.photoURLAtIndex(indexPath))
        
        cell.flickrTitleLabel.text = viewModel.titleAtIndex(indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("PhotoDetail", sender: indexPath)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        let y: CGFloat = offset.y + bounds.size.height - inset.bottom
        let h: CGFloat = size.height
        let reload_distance: CGFloat = 50
        if y > h + reload_distance {
            
            if viewModel.numberOfRow() > 0 {
                self.page += 1
                
                if self.page <= viewModel.pagesCount() {
                    self.callAPI(searchString!, pageNum: self.page)
                } else {
                    self.page -= 1
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let indexPath = (sender as! NSIndexPath)
        
        let cachedImage = SDImageCache.sharedImageCache()
        let photoURLString = viewModel.photoAtIndex(indexPath)
        let image = cachedImage!.imageFromDiskCacheForKey(photoURLString)
        
        if segue.identifier == "PhotoDetail" {
            let details = (segue.destinationViewController as! PhotoDetailsController)
            details.photoTitle = viewModel.titleAtIndex(indexPath)
            details.photoImage = image
        }
    }
}

