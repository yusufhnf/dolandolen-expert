//
//  SearchInteractor.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

protocol SearchUseCase {
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[GameModel]>
}

class SearchInteractor: SearchUseCase {
    private let gameRepository: GameRepository
    required init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[GameModel]> {
        return self.gameRepository.fetchGamesDataSearch(searchKeyword: searchKeyword)
    }
}
