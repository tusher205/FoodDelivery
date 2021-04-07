//
//  MoyaService.swift
//  FoodDelivery
//
//  Created by Takvir Hossain Tusher on 5/4/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import Moya

enum FoodService {
    case fetchFoodItems
    case fetchBanners
}

// MARK: - TargetType Protocol Implementation
extension FoodService: TargetType {
    var baseURL: URL { return URL(string: "https://api.myservice.com")! }
    var path: String {
        switch self {
        case .fetchFoodItems:
            return "/items"
        case .fetchBanners:
            return "/banners"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchFoodItems, .fetchBanners:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .fetchFoodItems, .fetchBanners: // Send no parameters
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .fetchFoodItems:
            return "".utf8Encoded
        case .fetchBanners:
            return "".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
