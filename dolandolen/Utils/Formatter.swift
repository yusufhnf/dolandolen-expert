//
//  Formatter.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import Foundation

struct Formatter {
    static private let dateTextFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
    func dateFormatter(dateValue: String?) -> String {
        var dateText: String {
            guard let releaseDate = dateValue, let date = Utils.dateFormatter.date(from: releaseDate) else {
                return "n/a"
            }
            return Formatter.dateTextFormatter.string(from: date)
        }
        return dateText
    }
}
