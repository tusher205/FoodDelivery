//
//  CartBuilder.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 6/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class CartBuilder {
    
    static func build() -> UIViewController {
        let view = CartViewController()
        let cartInteractor = CartInteractor()
        let router = CartRouter(view: view)
        let presenter = CartPresenter(view: view,
                                      router: router,
                                      useCase: (
                                        fetchCartItems: cartInteractor.fetchCartItems,
                                        addToCart: cartInteractor.addToCart,
                                        removeFromCart: cartInteractor.removeFromCart,
                                        resetCart: cartInteractor.resetCart,
                                        fetchDeliveryPrice: cartInteractor.fetchDeliveryPrice
                                            
        ))
        
        view.presenter = presenter
        return view
    }
}
