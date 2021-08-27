//
//  GameModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 19/08/21.
//

import Foundation

// MARK: - GameModel
struct GameModel: Codable {
    let results: [ResultGame]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct ResultGame: Codable {
    let name: String
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int?
    let idGame: Int
    let released: String?

    enum CodingKeys: String, CodingKey {
        case name, released
        case backgroundImage = "background_image"
        case rating
        case idGame = "id"
        case ratingTop = "rating_top"
    }
}
