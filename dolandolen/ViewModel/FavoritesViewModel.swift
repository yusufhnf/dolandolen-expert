//
//  FavoritesViewModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import Foundation

class FavoritesViewModel {
    var gameFavouritesResult = [GameFavoriteModel]()
    private lazy var gameProvider: GameProvider = { return GameProvider() }()
    init(gameProvider: GameProvider = GameProvider()) {
        self.gameProvider = gameProvider
    }
    func loadFavouriteData(completion: @escaping (Result<[GameFavoriteModel], NetworkErrorHandling>) -> Void) {
        self.gameProvider.getFavouritesData { result in
            switch result {
            case .success(let data):
                self.gameFavouritesResult = data
                completion(.success(data))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
            }
        }
    }
}
