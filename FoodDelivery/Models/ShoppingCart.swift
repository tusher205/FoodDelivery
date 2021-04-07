//
//  ShoppingCart.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingCart {
    static let sharedCart = ShoppingCart()
    var foodItems: BehaviorRelay<[FoodItem]> = BehaviorRelay(value: [])
}

//MARK: Non-Mutating Functions
extension ShoppingCart {
    var totalCost: Float {
        return foodItems.value.reduce(0) {
            runningTotal, item in
            return runningTotal + (item.price ?? 0)
        }
    }
    
    var totalItems: Int {
        return foodItems.value.reduce(0) {
            runningTotal, item in
            return runningTotal + item.count
        }
    }
    
    var itemCountString: String {
        guard foodItems.value.count > 0 else {
            return ""
        }
        
       return ""
    }
}

