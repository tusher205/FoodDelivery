//
//  HomeRouter.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

protocol HomeRouterProtocol {
    func moveToCartView()
}

class HomeRouter {
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func moveToCartView() {
        let cartView = CartBuilder.build()
        
        // Move to next page
        self.viewController.navigationController?.pushViewController(cartView, animated: true)
    }
    
}
