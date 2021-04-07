//
//  HomeViewBuilder.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class HomeViewBuilder {
    
    static func build() -> UIViewController {
        let view = HomeViewController()
        let foodItemInteractor = FoodItemsInteractor(service: FoodDeliveryService.shared)
        let imageInteractor = ImageInteractor(service: FoodDeliveryService.shared)
        let cartInteractor = CartInteractor()
        let router = HomeRouter(view: view)
        let presenter = HomeViewPresenter(view: view,
                                          router: router,
                                          useCase: (
                                            fetchItems: foodItemInteractor.fetchFoodItems,
                                            fetchBanners: foodItemInteractor.fetchBanners,
                                            fetchBannerImage: imageInteractor.fetchImage,
                                            fetchImage: imageInteractor.fetchImage,
                                            addToCart: cartInteractor.addToCart
        ))
        
        view.presenter = presenter
        
        return view
    }
}

