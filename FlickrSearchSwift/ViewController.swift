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

class ViewController: UIViewController {

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
        self.textfieldPadding()
        
        self.viewModel.setupArr()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 320
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.emptyTable()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Search Action
    @IBAction func searchFlickr(sender: AnyObject) {
        self.validateText()
    }
    
    // MARK: UITextfield Methods
    
    func textfieldPadding() -> Void {
        let textHeight = self.searchTextField.frame.size.height
        let paddingView = UIView(frame: CGRectMake(0, 0, 2, textHeight))
        self.searchTextField.leftView = paddingView
        self.searchTextField.leftViewMode = .Always
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        self.validateText()
        return true
    }
    
    // MARK: API Call
    
    func validateText() -> Void {
        self.searchTextField.resignFirstResponder()
        if self.searchTextField.text?.isEmpty == false {
            self.viewModel.setupArr()
            self.messageLabel!.text = ""
            self.searchString = self.searchTextField.text!
            self.callAPI(self.searchTextField.text!, pageNum: 1)
        }
    }
    
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
        //messageLabel!.text = "Please Try Search\nTo Find Images"
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
        
        cell.usernameLabel.text = viewModel.usernameAtIndex(indexPath)
        
        cell.profilePhoto.sd_setImageWithURL(viewModel.profileURLAtIndex(indexPath), placeholderImage: UIImage(named: "empty"))
        
        cell.flickrImageView.sd_setImageWithURL(viewModel.photoURLAtIndex(indexPath), placeholderImage: UIImage(named: "empty"))
        
        cell.flickrTitleLabel.text = viewModel.titleAtIndex(indexPath)
        cell.flickrTitleLabel.preferredMaxLayoutWidth = CGRectGetWidth(cell.flickrTitleLabel.frame)
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("PhotoDetail", sender: indexPath)
    }
    
    // MARK: ScrollView (on TableView)
    
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
        
        if let image:UIImage = self.viewModel.validateImageAtIndex(indexPath) {
                    
            if segue.identifier == "PhotoDetail" {
                let details = (segue.destinationViewController as! PhotoDetailsController)
                details.photoTitle = self.viewModel.titleAtIndex(indexPath)
                details.photoImage = image
                details.userName = self.viewModel.usernameAtIndex(indexPath)
                details.userProfile = self.viewModel.validateProfileAtIndex(indexPath)
            }
        }
    }
}
