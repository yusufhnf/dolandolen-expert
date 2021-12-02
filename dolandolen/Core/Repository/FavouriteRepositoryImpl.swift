//
//  FavouriteRepositoryImpl.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

class FavouriteRepositoryImpl: FavouriteRepository {
    private let gameLocalData: GameLocalData
    init(localData: GameLocalData) {
        self.gameLocalData = localData
    }
    func getFavouritesData() -> Observable<[GameModel]> {
        return gameLocalData.getFavouritesData()
            .map {GameMapper.mapGameEntitiesToDomains(input: $0)}
    }
    func addFavouriteGame(gameData: GameFavoriteEntity) -> Observable<Bool> {
        return gameLocalData.addFavouriteGame(gameData: gameData)
    }
    func isFavoritedGame(idGame: Int) -> Observable<Bool> {
        return gameLocalData.isFavoritedGame(idGame: idGame)
    }
    func deleteFavouriteGame(idGame: Int) -> Observable<Bool> {
        return gameLocalData.deleteFavouriteGame(idGame: idGame)
    }
}
