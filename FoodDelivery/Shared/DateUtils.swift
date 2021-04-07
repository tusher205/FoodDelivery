//
//  DateUtils.swift
//  ClassifiedDemo
//
//  Created by Takvir Hossain Tusher on 21/12/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import Foundation

class DateUtils: NSObject {
    
    @objc
    class func getFormatedDateFromString(_ dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = String("yyyy-MM-dd HH:mm:ss")
        
        if let date = getDateFromFormatter(dateFormatter, dateStr) {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        
        return ""
    }
    
    class func getDateFromFormatter(_ formatter: DateFormatter,
                                    _ dateStr: String) -> Date? {
        return formatter.date(from: String(dateStr.split(separator: ".").first ?? ""))
    }
}
