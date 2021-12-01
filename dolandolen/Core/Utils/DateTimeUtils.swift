//
//  DateTimeUtils.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 24/11/21.
//

import Foundation

class DateTimeUtils {
    static let dateTextFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}
