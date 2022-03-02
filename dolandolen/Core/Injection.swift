//
//  Injection.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 27/02/22.
//

import Foundation
import Core
import Game
import GameFavourite

final class Injection: NSObject {
    
    func provideGames<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
        let remote = GameRemoteDataSource(endpoint: Endpoints.Gets.gameList.url)
        let mapper = GameTransformer()
        let repository = GameRepository(
            remoteDataSource: remote,
            mapper: mapper
        )
        return (Interactor(repository: repository) as? U)!
    }
    
    func provideGameDetail<U: UseCase>() -> U where U.Request == String, U.Response == GameDetailModel {
        let remote = GameDetailRemoteDataSource(endpoint: Endpoints.Gets.gameDetail.url)
        let mapper = GameDetailTransformer()
        let repository = GameDetailRepository(
            remoteDataSource: remote,
            mapper: mapper
        )
        return (Interactor(repository: repository) as? U)!
    }
    
    func provideGetFavoriteGames<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
        let locale = GameFavouriteLocalData()
        let mapper = GameFavouriteTransformer()
        let repository = GetFavouritesDataRepository(
            gameFavouriteLocalData: locale,
            mapper: mapper
        )
        return (Interactor(repository: repository) as? U)!
    }
    
    func provideAddFavoriteGames<U: UseCase>() -> U where U.Request == GameDetailModel, U.Response == Bool {
        let locale = GameFavouriteLocalData()
        let mapper = AddGameFavouriteTransformer()
        let repository = AddFavouriteGameRepository(
            gameFavouriteLocalData: locale,
            mapper: mapper
        )
        return (Interactor(repository: repository) as? U)!
    }
    
    func provideDeleteFavoriteGames<U: UseCase>() -> U where U.Request == String, U.Response == Bool {
        let locale = GameFavouriteLocalData()
        let repository = DeleteFavouriteGameRepository(
            gameFavouriteLocalData: locale
        )
        return (Interactor(repository: repository) as? U)!
    }
    
    func provideStatusFavoriteGames<U: UseCase>() -> U where U.Request == String, U.Response == Bool {
        let locale = GameFavouriteLocalData()
        let repository = StatusFavouriteGameRepository(
            gameFavouriteLocalData: locale
        )
        return (Interactor(repository: repository) as? U)!
    }
    
}
