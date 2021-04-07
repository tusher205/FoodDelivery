//
//  HomeViewPresenter.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomePresenterProtocol {
    func loadViewData() -> Void
    func getCateogryName() -> String
    func getFoodItems() -> [FoodItem]
    func getHomeBanners() -> [HomeBanner]
    func getFoodItemsByCategoryId(_ catId: Int) -> [FoodItem]
    func addToCart(_ foodItem: FoodItem)
    func getFoodItemsCountInCart() -> Int
    func getCartObject() -> ShoppingCart
    func moveToCartView() -> Void
    
    func onFetchBanner(name: String, completion: @escaping ImageClosure)
    func onFetchImage(name: String, completion: @escaping ImageClosure)
}

class HomeViewPresenter: NSObject {
    
    // MARK: Properties
    weak var view: HomeViewProtocol?
    var router: HomeRouter
    
    typealias UseCase = (
        fetchItems: (_ completion: @escaping FoodItemsClosure) -> Void,
        fetchBanners: (_ completion: @escaping BannersClosure) -> Void,
        fetchBannerImage: (_ name: String, _ completion: @escaping ImageClosure) -> Void,
        fetchImage: (_ name: String, _ completion: @escaping ImageClosure) -> Void,
        addToCart: (_ item: FoodItem) -> Void
    )
    
    var interactors: UseCase?
    
    var foodItems: [FoodItem]?
    var homeBanners: [HomeBanner]?
    
    init(view: HomeViewProtocol,
         router: HomeRouter,
         useCase: HomeViewPresenter.UseCase) {
        
        self.view = view
        self.router = router
        self.interactors = useCase
    }
}

extension HomeViewPresenter: HomePresenterProtocol {
    func loadViewData() {
        // Fetch home banners
        if self.homeBanners?.count ?? 0 > 0 {
            self.updateView(for: .fetchBanner)
        } else {
            self.fetchBanners()
        }
        
        // Fetch items
        if self.foodItems?.count ?? 0 > 0 {
            // Items already featched
            self.updateView(for: .featchItems)
        } else {
            self.fetchItems()
        }
    }
    
    func getCateogryName() -> String {
        return "Pizza,Sushi,Drinks"
    }
    
    func getFoodItems() -> [FoodItem] {
        return self.foodItems ?? [FoodItem]()
    }
    
    func getHomeBanners() -> [HomeBanner] {
        return self.homeBanners ?? [HomeBanner]()
    }
    
    func addToCart(_ foodItem: FoodItem) {
        self.interactors?.addToCart(foodItem)
    }
    
    func getCartObject() -> ShoppingCart {
        return ShoppingCart.sharedCart
    }
    func getFoodItemsCountInCart() -> Int {
        return ShoppingCart.sharedCart.foodItems.value.count
    }
    
    func getFoodItemsByCategoryId(_ catId: Int) -> [FoodItem] {
        var items = [FoodItem]()
        
        if let foodItems = self.foodItems {
            for item in foodItems {
                if (item.catId ?? -1) == catId {
                    items.append(item)
                }
            }
        }
        
        return items
    }
    
    func moveToCartView() {
        self.router.moveToCartView()
    }
    
    func onFetchBanner(name: String, completion: @escaping ImageClosure) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactors?.fetchBannerImage(name) { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func onFetchImage(name: String, completion: @escaping ImageClosure) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactors?.fetchImage(name) { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
}

extension HomeViewPresenter {
    func fetchBanners() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactors?.fetchBanners { (response) in
                if response.count > 0 {
                    print("Received home banners: \(response.count)")
                    self?.homeBanners = response
                    self?.updateView(for: .fetchBanner)
                } else {
                    self?.updateView(for: .fetchError)
                }
            }
        }
    }
    
    func fetchItems() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactors?.fetchItems { (response) in
                if response.count > 0 {
                    print("Received Food Items: \(response.count)")
                    self?.foodItems = response
                    self?.updateView(for: .featchItems)
                } else {
                    self?.updateView(for: .fetchError)
                }
            }
        }
    }

    func updateView(for state: ViewUpdateState) {
        DispatchQueue.main.async { [weak self] in
            switch state {
            case .featchItems:
                self?.view?.showFoodItems()

            case .fetchImage:
                break
                
            case .fetchBanner:
                self?.view?.showHomeBanners()

            case .fetchError:
                self?.view?.showError()
            }
        }
    }

}

