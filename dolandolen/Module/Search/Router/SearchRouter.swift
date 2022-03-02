//
//  SearchRouter.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 29/11/21.
//

import Foundation
import Game
import Core
import GameFavourite

class SearchRouter {
    static func pushToDetailView (idGame: Int) -> DetailViewController {
        let gameDetailVC = DetailViewController()
        
        let gameDetailUseCase: Interactor<
            String,
            GameDetailModel,
            GameDetailRepository<
                GameDetailRemoteDataSource,
                GameDetailTransformer>
        > = Injection.init().provideGameDetail()
        
        let addFavoriteUseCase: Interactor<
            GameDetailModel,
            Bool,
            AddFavouriteGameRepository<
                GameFavouriteLocalData,
                AddGameFavouriteTransformer>
        > = Injection.init().provideAddFavoriteGames()
        
        let deleteFavoriteUseCase: Interactor<
            String,
            Bool,
            DeleteFavouriteGameRepository<
                GameFavouriteLocalData
            >
        > = Injection.init().provideDeleteFavoriteGames()
        
        let statusFavoriteUseCase: Interactor<
            String,
            Bool,
            StatusFavouriteGameRepository<
                GameFavouriteLocalData
            >
        > = Injection.init().provideStatusFavoriteGames()
        
        let presenter = GameDetailPresenter(
            gameDetailUseCase: gameDetailUseCase,
            addGameFavouriteUseCase: addFavoriteUseCase,
            removeGameFavouriteUseCase: deleteFavoriteUseCase,
            statusGameFavouriteUseCase: statusFavoriteUseCase
        )
        
        gameDetailVC.idGame = idGame
        gameDetailVC.presenter = presenter
        return gameDetailVC
    }
}
