//
//  HomeBanner.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import ObjectMapper

class BannerResults: Mappable {
    private(set) var results: [HomeBanner] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        results <- (map["results"], HomeBannerTransformType())
    }
}

class HomeBanner: Mappable {
    var id: String?
    var image: String?
    var name: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        image <- map["image"]
        name <- map["name"]
    }
}

class HomeBannerTransformType: TransformType {
    
    public typealias Object = [HomeBanner]
    
    public typealias JSON = [[String: Any]]
    
    func transformToJSON(_ value: [HomeBanner]?) -> [[String : Any]]? {
        guard let foodItems = value else {return nil}
        return foodItems.map { $0.toJSON() }
    }
    
    func transformFromJSON(_ value: Any?) -> [HomeBanner]? {
        guard let items = value as? [[String: Any]] else {return nil}
        return items.compactMap { dictionary -> HomeBanner? in
            if let food = HomeBanner(JSON: dictionary) {return food}
            return nil
        }
    }
    
}

extension HomeBanner {
    static func getStubResponse() -> String {
        let data = """
{"results":[{"id":"01","name":"Potter","image":"meal3"},{"id":"02","name":"Potter","image":"meal2"},{"id":"03","name":"Potter","image":"meal1"}]}
"""
        return data
    }
}
