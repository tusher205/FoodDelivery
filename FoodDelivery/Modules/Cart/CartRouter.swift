//
//  CartRouter.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 6/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//
import UIKit

protocol CartRouterProtocol {
    
}

class CartRouter {
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }
}
