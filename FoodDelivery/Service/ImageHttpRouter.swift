//
//  ImageHttpRouter.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 22/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

import Alamofire

enum ImageHttpRouter {
    case downloadThumbnail(imageName: String)
    case downloadImage(imageName: String)
}

extension ImageHttpRouter: HttpRouter {
    var baseUrlString: String {
        switch (self) {
        case .downloadImage(let imageUrl),
             .downloadThumbnail(let imageUrl):
            
            // Remove path trailing backslash, if any
            if var url = URLComponents(string: imageUrl) {
                
                if url.path.last == "/" {
                    url.path = String(url.path.dropLast())
                }
                
                return url.string ?? ""
            }
            
            return imageUrl
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .downloadImage, .downloadThumbnail:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrlString.asURL()
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request.httpBody = try body()
        return request
    }
    
    func download(using httpService: ImageHttpService,
                  completion: @escaping ImageDataResponse) throws -> Void {
        try httpService.download(asURLRequest(), completion: completion)
    }
}
