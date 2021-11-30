//
//  DateTimeUtils.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 24/11/21.
//

import Foundation

class DateTimeUtils {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}

struct Formatter {
    static private let dateTextFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
    func dateFormatter(dateValue: String?) -> String {
        var dateText: String {
            guard let releaseDate = dateValue, let date = DateTimeUtils.dateFormatter.date(from: releaseDate) else {
                return "n/a"
            }
            return Formatter.dateTextFormatter.string(from: date)
        }
        return dateText
    }
}
