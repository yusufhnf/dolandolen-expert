//
//  GameDetailModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 19/08/21.
//

import Foundation

// MARK: - GameDetailModel
struct GameDetailResponse: Codable {
    let idGame: Int
    let name, gameDetailModelDescription: String
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int?
    let released: String?

    enum CodingKeys: String, CodingKey {
        case name, released
        case idGame = "id"
        case gameDetailModelDescription = "description_raw"
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
    }
}
