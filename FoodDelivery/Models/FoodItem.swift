//
//  FoodItem.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 4/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import ObjectMapper

class FoddItemResults: Mappable {
    private(set) var results: [FoodItem] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        results <- (map["results"], FoodItemsTransformType())
    }
}

class FoodItem: Mappable {
    var uid: String?
    var catId: Int?
    var name: String?
    var description: String?
    var weight: String?
    var length: String?
    var price: Float?
    var createdAt : String?
    var image: String?
    var count: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        uid <- map["id"]
        catId <- map["catId"]
        name <- map["name"]
        description <- map["desc"]
        weight <- map["weight"]
        length <- map["length"]
        price <- map["price"]
        createdAt <- map["created"]
        image <- map["image"]
    }
}

extension FoodItem: Hashable {
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}

extension FoodItem {
    static func getStubResponse() -> String {
        let data = """
{"results":[{"id":"01","catId":0,"name":"Deluxe","desc":"Chiken, ham, peperoni, tomato sauce, spicy chorize and mozzarella","weight":"150 gm","length":"35 cm","price":46,"created":"1507709926","image":"pizza1"},{"id":"02","catId":0,"name":"Hawaiian","desc":"Chicken, Mozarella, Pineapple, Domino's sause","weight":"200 gm","length":"35 cm","price":55,"created":"1507709926","image":"pizza2"},{"id":"03","catId":0,"name":"Pepperoni","desc":"Mozzarella, Pepperoni, Tomatoes, BBQ Sause","weight":"190 gm","length":"40 cm","price":55,"created":"1507709926","image":"pizza3"},{"id":"04","catId":0,"name":"Potter","desc":"Tomato, Marshmallow, Potato","weight":"235 gm","length":"35 cm","price":55,"created":"1507709926","image":"pizza4"},{"id":"05","catId":1,"name":"The egoist","desc":"Fila classic, maci spice, salmon, two sushi, two generous salami","weight":"450 gm","length":"18 piece","price":45,"created":"1507709926","image":"sushi1"},{"id":"06","catId":1,"name":"California","desc":"California with salmon grill, maci spice, salmon, two sushi, two generous salami","weight":"255 gm","length":"20 piece","price":60,"created":"1507709926","image":"sushi2"},{"id":"07","catId":2,"name":"Chocolate milkshake","desc":"Fila classic, maci spice, salmon, two sushi, two generous salami","weight":"250 gm","length":"1 piece","price":45,"created":"1507709926","image":"drinks1"},{"id":"08","catId":2,"name":"Pepsi","desc":"California with salmon grill, maci spice, salmon, two sushi, two generous salami","weight":"255 gm","length":"2 piece","price":20,"created":"1507709926","image":"drinks2"}]}
"""
        
        return data
    }
}

class FoodItemsTransformType: TransformType {
    
    public typealias Object = [FoodItem]
    public typealias JSON = [[String: Any]]
    
    func transformToJSON(_ value: [FoodItem]?) -> [[String : Any]]? {
        guard let foodItems = value else {return nil}
        return foodItems.map { $0.toJSON() }
    }
    
    func transformFromJSON(_ value: Any?) -> [FoodItem]? {
        guard let items = value as? [[String: Any]] else {return nil}
        return items.compactMap { dictionary -> FoodItem? in
            if let food = FoodItem(JSON: dictionary) {return food}
            return nil
        }
    }
    
}
