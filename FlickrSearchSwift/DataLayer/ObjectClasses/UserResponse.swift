//
//  UserResponse.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/28/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import ObjectMapper

class UserResponse: Mappable {

    var stat: String?
    var person: Person?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        stat <- map["stat"]
        person <- map["person"]
    }
    
}
