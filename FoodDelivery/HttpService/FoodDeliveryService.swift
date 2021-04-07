//
//  FoodDeliveryService.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Alamofire
import Moya

class FoodDeliveryService {
    private lazy var httpService = ClassifiedHttpService()
    private lazy var imageService = ImageHttpService()
    
    private lazy var provider = MoyaProvider<FoodService>()
    
    static let shared : FoodDeliveryService = FoodDeliveryService()
}

extension FoodDeliveryService: FoodItemsAPI {
    func fetchFoodItems(completion: @escaping FoodItemsClosure) {
        provider.request(.fetchFoodItems) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filderedResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    if let data = FoodItemsTransformType().transformFromJSON(filderedResponse) {
                        completion(data)
                    }
                }
                catch {
                    // show an error to your user
                    print("Something went wrong while fetching food items")
                }
                
                // do something in your app
            case let .failure(error):
                print("Something went wrong while fetching food items \(error)")
                
                // Mocking dummy response
                let response = FoodItem.getStubResponse()
                if let data = FoddItemResults(JSONString: response){
                    completion(data.results)
                }
            }
        }
        
//        // Making http call to fetch food items
//        do {
//            try ClassifiedHttpRouter
//                .getClassifiedItems
//                .request(usingHttpService: httpService)
//                .responseJSON { (response) in
//
//                    let result = FoodDeliveryService.parseFoodItems(response)
//                    completion(result)
//            }
//        } catch {
//            print("Something went wrong while fetching food items \(error)")
//        }
    }
    
    func fetchBanners(completion: @escaping BannersClosure) {
        provider.request(.fetchBanners) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    if let jsonData = HomeBannerTransformType().transformFromJSON(filteredResponse) {
                        completion(jsonData)
                    }
                }
                catch {
                    // show an error to your user
                    print("Something went wrong while fetching home banners")
                }
                
                // do something in your app
            case let .failure(error):
                print("Something went wrong while fetching home banners \(error)")
                
                // Mocking dummy response
                let response = HomeBanner.getStubResponse()
                if let data = BannerResults(JSONString: response) {
                    completion(data.results)
                }
            }
        }
    }
    
}

extension FoodDeliveryService: ImagesAPI {
    func fetchThumbnail(name: String, completion: @escaping ImageClosure) {
        do {
            try ImageHttpRouter
                .downloadThumbnail(imageName: name)
                .download(using: imageService) { response in
                    guard let data = response.data, let image = UIImage(data: data) else { return }
                    completion(image)
                }
        } catch {
            print("Something went wrong while fetching thumbnail! = \(error)")
        }
    }
    
    func fetchImage(name: String, completion: @escaping ImageClosure) {
        do {
            try ImageHttpRouter
                .downloadImage(imageName: name)
                .download(using: imageService) { response in
                    guard let data = response.data, let image = UIImage(data: data) else {
                        // Mocking response
                        if let image = UIImage(named: name) {
                            completion(image)
                        }
                        return
                    }
                    completion(image)
                }
        } catch {
            print("Something went wrong while fetching image! = \(error)")
        }
    }
    
}
