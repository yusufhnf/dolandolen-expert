//
//  GameModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 02/12/21.
//

import Foundation

struct GameModel {
    let name: String
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int?
    let idGame: Int
    let released: String?
    var releasedDateText: String {
        guard let releaseDate = released, let date = DateTimeUtils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return DateTimeUtils.dateTextFormatter.string(from: date)
    }
}
