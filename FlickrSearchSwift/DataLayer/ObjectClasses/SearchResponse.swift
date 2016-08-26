//
//  SearchResponse.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import ObjectMapper

class SearchResponse: Mappable {
    
    var stat: String?
    var photos: Photos?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        stat <- map["stat"]
        photos <- map["photos"]
    }
}
