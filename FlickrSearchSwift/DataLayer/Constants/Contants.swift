//
//  Contants.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import Foundation

struct Constants {
    static let flickrAPIKey = ""
    static let flickAPI = "https://api.flickr.com/services/rest/?method="
    
    static let searchPhotoURL = "\(flickAPI)flickr.photos.search&api_key=\(flickrAPIKey)&text={text}&per_page=10&format=json&page={page}&privacy_filter=1&nojsoncallback=1"
    
    static let userInfoURL = "\(flickAPI)flickr.people.getInfo&api_key=\(flickrAPIKey)&user_id={user_id}&format=json&nojsoncallback=1"
}