//
//  GameDetailModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 02/12/21.
//

import Foundation

struct GameDetailModel {
    let idGame: Int
    let name, gameDetailModelDescription: String
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int?
    let released: String?
    var dateText: String {
        guard let releaseDate = released, let date = DateTimeUtils.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return DateTimeUtils.dateTextFormatter.string(from: date)
    }
}
