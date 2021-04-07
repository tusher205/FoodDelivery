//
//  CartInteractor.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 6/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

protocol CartInteractorProtocol {
    func fetchCartItems() -> [FoodItem]
    func addToCart(_ item: FoodItem) -> Void
    func removeFromCart(_ item: FoodItem) -> Void
    func resetCart() -> Void
    func fetchDeliveryPrice() -> Float
}

class CartInteractor {
    init() {
        
    }
}

extension CartInteractor: CartInteractorProtocol {
    func fetchCartItems() -> [FoodItem] {
        return ShoppingCart.sharedCart.foodItems.value
    }
    
    func addToCart(_ item: FoodItem) {
        var setOfItems = Set<FoodItem>(fetchCartItems())
        
        if setOfItems.contains(item),
            let currentItem = setOfItems.remove(item) {
            currentItem.price = (currentItem.price ?? 0) + (item.price ?? 0)
            currentItem.count += 1
            
            setOfItems.insert(currentItem)
        } else {
            item.count = 1
            setOfItems.insert(item)
        }
        
        let updatedItems = Array(setOfItems)
        ShoppingCart.sharedCart.foodItems.accept(updatedItems)
    }
    
    func removeFromCart(_ item: FoodItem) {
        var items = ShoppingCart.sharedCart.foodItems.value
        
        var idx = -1
        for (i, foodItem) in items.enumerated() {
            if foodItem.uid == item.uid {
                idx = i
                break
            }
        }
        
        if idx >= 0 {
            items.remove(at: idx)
            ShoppingCart.sharedCart.foodItems.accept(items)
        }
    }
    
    func resetCart() {
        ShoppingCart.sharedCart.foodItems.accept([])
    }
    
    func fetchDeliveryPrice() -> Float {
        return 0
    }
    
    
}
