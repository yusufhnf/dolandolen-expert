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
    func getFavouritesData() -> Observable<[GameFavoriteModel]> {
        return gameLocalData.getFavouritesData()
    }
    func getFavouriteGameDetail(idGame: Int) -> Observable<GameFavoriteModel> {
        return gameLocalData.getFavouriteGameDetail(idGame: idGame)
    }
    func addFavouriteGame(gameData: GameDetailModel) -> Observable<Bool> {
        return gameLocalData.addFavouriteGame(gameData: gameData)
    }
    func isFavoritedGame(idGame: Int) -> Observable<Bool> {
        return gameLocalData.isFavoritedGame(idGame: idGame)
    }
    func deleteFavouriteGame(idGame: Int) -> Observable<Bool> {
        return gameLocalData.deleteFavouriteGame(idGame: idGame)
    }
}
