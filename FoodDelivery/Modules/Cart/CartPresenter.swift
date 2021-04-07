//
//  CartPresenter.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 6/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol CartPresenterProtocol {
    func loadViewData() -> Void
    func getCartItems() -> [FoodItem]
    func getTotalPrice() -> Float
    func getCurrency() -> String
    func getDeliveryFare() -> String
    func getCartObject() -> ShoppingCart
    func removeFromCart(_ item: FoodItem) -> Void
}

class CartPresenter: NSObject {
    
    // MARK: Properties
    weak var view: CartViewProtocol?
    var router: CartRouter
    
    typealias UseCase = (
        fetchCartItems: () -> [FoodItem],
        addToCart: (_ item: FoodItem) -> Void,
        removeFromCart: (_ item: FoodItem) -> Void,
        resetCart: () -> Void,
        fetchDeliveryPrice: () -> Float
    )
    
    var interactors: UseCase?
    var foodItems: [FoodItem]?
    
    init(view: CartViewProtocol,
         router: CartRouter,
         useCase: CartPresenter.UseCase) {
        
        self.view = view
        self.router = router
        self.interactors = useCase
    }
}

extension CartPresenter: CartPresenterProtocol {
 
    func getCartObject() -> ShoppingCart {
        return ShoppingCart.sharedCart
    }
    
    func loadViewData() {
        self.view?.showCartItems()
    }
    
    func getCartItems() -> [FoodItem] {
        self.foodItems = self.interactors?.fetchCartItems()
        return self.foodItems ?? [FoodItem]()
    }
    
    func getTotalPrice() -> Float {
        self.getCartObject().totalCost
    }
    
    func getCurrency() -> String {
        return "USD" // Default
    }
    
    func removeFromCart(_ item: FoodItem) {
        self.interactors?.removeFromCart(item)
    }
     
    func getDeliveryFare() -> String {
        let fare = self.interactors?.fetchDeliveryPrice() ?? 0
        if fare > 0 {
            return "\(fare) \(self.getCurrency())"
        }
        
        return "Delivery is free."
    }
    
}
