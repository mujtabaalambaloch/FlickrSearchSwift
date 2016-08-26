//
//  Contants.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import Foundation

struct Constants {
    static let flickrAPIKey = "b1b93de405ea726a15d4103d0fe78d88"
    
    static let searchPhotoURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(flickrAPIKey)&text={text}&per_page=10&format=json&page={page}&safe_search=1&privacy_filter=1&nojsoncallback=1"
    
    static let photoImage = "https://farm{farm}.staticflickr.com/{server}/{photoID}_{secret}_h.jpg"
}