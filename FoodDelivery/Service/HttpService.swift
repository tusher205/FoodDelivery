//
//  HttpService.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Alamofire

protocol HttpService {
    var sessionManager: SessionManager { get set }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
