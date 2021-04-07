//
//  ImagesAPI.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 22/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

typealias ImageClosure = (UIImage) -> (Void)

protocol ImagesAPI {
    func fetchThumbnail(name: String, completion: @escaping ImageClosure) -> Void
    func fetchImage(name: String, completion: @escaping ImageClosure) -> Void
}
