//
//  ViewModel.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewModel: NSObject {
    
    var photoArr = [Photo]()
    var totalPages: Int?
    
    // MARK: Setup Array
    
    func setupArr() -> Void {
        self.photoArr.removeAll()
    }
    
    // MARK: API Call
    
    func apiCall(text:String, page:Int, completion: ((success : Bool!) -> Void)?) {
        
        var newURL = replaceString(Constants.searchPhotoURL, target:"{page}", with: String(page))
        let textString = text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        newURL = replaceString(newURL, target:"{text}", with:textString!)
        
        Alamofire.request(.GET, newURL).responseObject { (response: Response<SearchResponse, NSError>) in
            
            let searchResponse = response.result.value
            
            if let photos = searchResponse?.photos {
                
                self.totalPages = photos.pages
                
                for one in photos.photo! {
                    self.photoArr.append(one)
                }
                
                if self.photoArr.count > 0 {
                    completion!(success: true)
                } else {
                    completion!(success: false)
                }
            }
        }
    }
    
    // MARK: Replace String Method
    
    func replaceString(string:String, target:String, with:String) -> String {
        return string.stringByReplacingOccurrencesOfString(target, withString: with)
    }
    
    // MARK: TableView Data Methods
    
    func numberOfRow() -> Int {
        return self.photoArr.count
    }
    
    func titleAtIndex(indexPath: NSIndexPath) -> String {
        return self.photoArr[indexPath.row].title!
    }
    
    func photoAtIndex(indexPath: NSIndexPath) -> String {
        return self.photoArr[indexPath.row].url!
    }
    
    func photoURLAtIndex(indexPath: NSIndexPath) -> NSURL {
        return NSURL(string:self.photoArr[indexPath.row].url!)!
    }
    
    func photoObjectAtIndex(indexPath: NSIndexPath) -> Photo {
        return self.photoArr[indexPath.row]
    }
    
    // MARK: Total Pages
    
    func pagesCount() -> Int {
        return self.totalPages!
    }
    
}
