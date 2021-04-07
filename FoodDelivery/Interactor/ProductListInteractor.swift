//
//  ProductListInteractor.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

protocol ProductInteractor {
    func fetchClassifiedItems(completion: @escaping ClassifiedClosure) -> Void
}

class ProductListInteractor {
    var classifiedService: ClassifiedAPI
    
    init(service: ClassifiedAPI) {
        self.classifiedService = service
    }
}

extension ProductListInteractor: ProductInteractor {
    func fetchClassifiedItems(completion: @escaping ClassifiedClosure) {
        self.classifiedService.fetchClassifiedProducts(completion: completion)
    }
}
