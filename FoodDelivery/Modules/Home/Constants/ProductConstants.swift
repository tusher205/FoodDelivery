//
//  ProductConstants.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 20/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

@objc
enum ClassifiedListSectionIdentifier: Int {
    case section1 = 0
    case sectionCount // Keep at the last item
}

@objc
enum ClassifiedDetailCellIdentifier: Int {
    case itemPrice = 0
    case itemUid
    case itemPostedDate
    case itemCount // Keep at the last item
}

@objc
enum ClassifiedListSegmentIndex: Int {
    case Name = 0
    case Price
}

enum ViewUpdateState: Int {
    case featchItems = 0
    case fetchBanner
    case fetchImage
    case fetchError
}
