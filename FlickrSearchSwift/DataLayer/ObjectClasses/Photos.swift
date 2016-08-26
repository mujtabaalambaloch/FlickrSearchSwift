//
//  Photos.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import ObjectMapper

class Photos: Mappable {
    
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: String?
    var photo: [Photo]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        pages <- map["pages"]
        perpage <- map["perpage"]
        total <- map["total"]
        photo <- map["photo"]
    }
}
