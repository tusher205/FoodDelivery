//
//  ImageInteractor.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 22/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

final class ImageInteractor {
    let service: ImagesAPI
    
    init(service: ImagesAPI) {
        self.service = service
    }
}

extension ImageInteractor {
    func fetchThumbnail(name: String, completion: @escaping ImageClosure) -> Void {
        self.service.fetchThumbnail(name: name, completion: completion)
    }
    
    func fetchImage(name: String, completion: @escaping ImageClosure) -> Void {
        self.service.fetchImage(name: name, completion: completion)
    }
}
