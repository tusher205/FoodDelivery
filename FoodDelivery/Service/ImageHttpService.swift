//
//  ImageHttpService.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 22/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Alamofire
import AlamofireImage

typealias ImageDataResponse = (DataResponse<Image>) -> (Void)

final class ImageHttpService {
    let imageDownloader: ImageDownloader
    
    static let shared: ImageHttpService = ImageHttpService()
    
    init() {
        self.imageDownloader = ImageDownloader()
    }
    
    func download(_ urlRequest: URLRequestConvertible, completion: @escaping ImageDataResponse) -> Void {
        imageDownloader.download(urlRequest, completion: completion)
    }
}
