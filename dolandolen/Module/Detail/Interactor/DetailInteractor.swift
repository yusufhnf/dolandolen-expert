//
//  DetailInteractor.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailModel>
    func addFavouriteGame(gameData: GameFavoriteEntity) -> Observable<Bool>
    func isFavoritedGame(idGame: Int) -> Observable<Bool>
    func deleteFavouriteGame(idGame: Int) -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {
    private let gameRepository: GameRepository
    private let favouriteRepository: FavouriteRepository
    required init(gameRepository: GameRepository, favouriteRepository: FavouriteRepository) {
        self.gameRepository = gameRepository
        self.favouriteRepository = favouriteRepository
    }
    func addFavouriteGame(gameData: GameFavoriteEntity) -> Observable<Bool> {
        return favouriteRepository.addFavouriteGame(gameData: gameData)
    }
    func isFavoritedGame(idGame: Int) -> Observable<Bool> {
        return favouriteRepository.isFavoritedGame(idGame: idGame)
    }
    func deleteFavouriteGame(idGame: Int) -> Observable<Bool> {
        return favouriteRepository.deleteFavouriteGame(idGame: idGame)
    }
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailModel> {
        return gameRepository.fetchGameDetail(idGame: idGame)
    }
}
