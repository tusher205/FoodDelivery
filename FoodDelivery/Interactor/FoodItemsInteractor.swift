//
//  FoodItemsInteractor.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

protocol FoodItemsInteractorProtocol {
    func fetchFoodItems(completion: @escaping FoodItemsClosure) -> Void
    func fetchBanners(completion: @escaping BannersClosure) -> Void
}

class FoodItemsInteractor {
    var foodDeliveryService: FoodItemsAPI
    
    init(service: FoodItemsAPI) {
        self.foodDeliveryService = service
    }
}

extension FoodItemsInteractor: FoodItemsInteractorProtocol {
    func fetchFoodItems(completion: @escaping FoodItemsClosure) {
        self.foodDeliveryService.fetchFoodItems(completion: completion)
    }
    
    func fetchBanners(completion: @escaping BannersClosure) {
        self.foodDeliveryService.fetchBanners(completion: completion)
    }
}

