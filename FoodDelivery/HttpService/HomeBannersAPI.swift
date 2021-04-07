//
//  HomeBannersAPI.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation

typealias BannersClosure = ([HomeBanner]) -> (Void)

protocol HomeBannersAPI {
    func fetchBanners(completion: @escaping BannersClosure) -> (Void)
}
