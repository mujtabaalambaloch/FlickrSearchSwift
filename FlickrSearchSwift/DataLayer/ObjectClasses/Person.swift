//
//  Person.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/28/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import ObjectMapper

class Person: Mappable {

    var iconfarm : Int?
    var iconserver : String?
    var nsid : String?
    var realname : String?
    var profileImage: String?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        iconfarm <- map["iconfarm"]
        iconserver <- map["iconserver"]
        nsid <- map["nsid"]
        realname <- map["realname._content"]
        
        if iconserver == "buddyicon" {
            profileImage = "https://www.flickr.com/images/buddyicon.gif"
        } else {
            profileImage = "https://farm\(iconfarm!).staticflickr.com/\(iconserver!)/buddyicons/\(nsid!).jpg"
        }
    }
}
