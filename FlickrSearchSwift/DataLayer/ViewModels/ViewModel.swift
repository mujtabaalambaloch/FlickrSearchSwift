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
import SDWebImage

class ViewModel: NSObject {
    
    private var photoArr = [Photo]()
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
                var count = 0
                for one in photos.photo! {
                    
                    let userURL = self.replaceString(Constants.userInfoURL, target:"{user_id}", with: one.owner!)
                    
                    Alamofire.request(.GET, userURL).responseObject { (response: Response<UserResponse, NSError>) in
                        let userReponse = response.result.value
                        one.username = userReponse?.person?.realname
                        one.profileImage = userReponse?.person?.profileImage
                        
                        self.photoArr.append(one)
                        
                        if count >= 9 {
                            if self.photoArr.count > 0 {
                                completion!(success: true)
                            } else {
                                completion!(success: false)
                            }
                        } else {
                            count += 1
                        }
                    }
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
    
    func usernameAtIndex(indexPath:NSIndexPath) -> String {
        
        if let name = self.photoArr[indexPath.row].username {
            return name
        } else {
            return ""
        }
    }
    
    func profileURLAtIndex(indexPath:NSIndexPath) -> NSURL {
        return NSURL(string:self.photoArr[indexPath.row].profileImage!)!
    }
    
    func profileAtIndex(indexPath: NSIndexPath) -> String {
        return self.photoArr[indexPath.row].profileImage!
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
    
    func validateProfileAtIndex(indexPath: NSIndexPath) -> UIImage {
        let cachedImage = SDImageCache.sharedImageCache()
        let profileURL = self.profileAtIndex(indexPath)
        return cachedImage!.imageFromDiskCacheForKey(profileURL)
    }
    
    func validateImageAtIndex(indexPath: NSIndexPath) -> UIImage {
        let cachedImage = SDImageCache.sharedImageCache()
        let photoURLString = self.photoAtIndex(indexPath)
        return cachedImage!.imageFromDiskCacheForKey(photoURLString)
    }
    
    // MARK: Total Pages
    
    func pagesCount() -> Int {
        return self.totalPages!
    }
    
}
