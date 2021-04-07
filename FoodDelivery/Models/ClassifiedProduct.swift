//
//  ClassifiedProduct.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 28/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

@objcMembers
class ClassifiedProduct : NSObject, Codable {
    var createdAt : String?
    var price : String?
    var name : String?
    var uid : String?
    var imageIds : [String]?
    var imageUrls : [String]?
    var imageUrlsThumbnails : [String]?

    enum CodingKeys: String, CodingKey {

        case createdAt = "created_at"
        case price = "price"
        case name = "name"
        case uid = "uid"
        case imageIds = "image_ids"
        case imageUrls = "image_urls"
        case imageUrlsThumbnails = "image_urls_thumbnails"
    }
    
    override init() {
        // Default init
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        uid = try values.decodeIfPresent(String.self, forKey: .uid)
        imageIds = try values.decodeIfPresent([String].self, forKey: .imageIds)
        imageUrls = try values.decodeIfPresent([String].self, forKey: .imageUrls)
        imageUrlsThumbnails = try values.decodeIfPresent([String].self, forKey: .imageUrlsThumbnails)
    }

}
