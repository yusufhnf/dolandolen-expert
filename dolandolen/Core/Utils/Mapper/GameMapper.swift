//
//  GameMapper.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 01/12/21.
//

import Foundation

final class GameMapper {
    static func mapGameResponseToDomain(
        input gameResponse: [ResultGame]
    ) -> [GameModel] {
        return gameResponse.map { result in
            return GameModel(
                name: result.name,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                ratingTop: result.ratingTop,
                idGame: result.idGame,
                released: result.released
            )
        }
    }
    static func mapGameDetailResponseToDomain(
        input gameDetailResponse: GameDetailResponse
    ) -> GameDetailModel {
        return GameDetailModel(
            idGame: gameDetailResponse.idGame,
            name: gameDetailResponse.name,
            gameDetailModelDescription: gameDetailResponse.gameDetailModelDescription,
            backgroundImage: gameDetailResponse.backgroundImage,
            rating: gameDetailResponse.rating,
            ratingTop: gameDetailResponse.ratingTop,
            released: gameDetailResponse.released
        )
    }
    static func mapGameDetailModelToEntity(
        input gameDetailModel: GameDetailModel
    ) -> GameFavoriteEntity {
        var newGame = GameFavoriteEntity()
        newGame.idGame = Int32(gameDetailModel.idGame)
        newGame.name = gameDetailModel.name
        newGame.description = gameDetailModel.gameDetailModelDescription
        newGame.backgroundImage = gameDetailModel.backgroundImage
        newGame.rating = gameDetailModel.rating
        newGame.ratingTop = Int32(gameDetailModel.ratingTop ?? 0)
        newGame.releaseDate = gameDetailModel.released
        return newGame
    }
    static func mapGameEntitiesToDomains(
        input gameEntities: [GameFavoriteEntity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(
                name: result.name ?? "-",
                backgroundImage: result.backgroundImage,
                rating: result.rating ?? 0.0,
                ratingTop: Int(result.ratingTop ?? 0),
                idGame: Int(result.idGame ?? 0),
                released: result.releaseDate
            )
        }
    }
    
}
