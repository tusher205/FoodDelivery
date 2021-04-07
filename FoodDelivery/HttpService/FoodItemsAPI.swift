//
//  FoodItemsAPI.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

typealias FoodItemsClosure = ([FoodItem]) -> (Void)

protocol FoodItemsAPI {
    func fetchFoodItems(completion: @escaping FoodItemsClosure) -> (Void)
    func fetchBanners(completion: @escaping BannersClosure) -> (Void)
}
