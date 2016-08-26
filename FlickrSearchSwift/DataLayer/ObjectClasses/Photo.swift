//
//  Photo.swift
//  FlickrSearchSwift
//
//  Created by Mujtaba Alam on 8/26/16.
//  Copyright © 2016 Mujtaba Alam. All rights reserved.
//

import ObjectMapper

class Photo: Mappable {
    
    var farm: Int?
    var id: String?
    var isfamily: Bool?
    var isfriend: Bool?
    var ispublic: Bool?
    var owner: String?
    var secret: String?
    var server: String?
    var title: String?
    
    var url: String?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        
        farm <- map["farm"]
        id <- map["id"]
        isfamily <- map["isfamily"]
        isfriend <- map["isfriend"]
        ispublic <- map["ispublic"]
        owner <- map["owner"]
        secret <- map["secret"]
        server <- map["server"]
        title <- map["title"]
        url = "https://farm\(farm!).staticflickr.com/\(server!)/\(id!)_\(secret!)_h.jpg"
    }
}
