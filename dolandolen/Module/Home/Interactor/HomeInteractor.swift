//
//  HomeInteractor.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func fetchGamesData() -> Observable<[GameModel]>
}
class HomeInteractor: HomeUseCase {
    private let gameRepository: GameRepository
    required init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    func fetchGamesData() -> Observable<[GameModel]> {
        return self.gameRepository.fetchGamesData()
    }
}
