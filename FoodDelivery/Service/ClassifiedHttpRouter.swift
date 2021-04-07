//
//  ClassifiedHttpRouter.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Alamofire

enum ClassifiedHttpRouter {
    case getClassifiedItems
}

extension ClassifiedHttpRouter: HttpRouter {
    var baseUrlString: String {
        return "https://"
    }
    
    var path: String {
        return "/"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json; charset=UTF-8"]
    }
    
    func body() throws -> Data? {
        switch self {
        case .getClassifiedItems:
            return nil
        }
    }
}
