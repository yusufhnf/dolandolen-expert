//
//  GameRepositoryImpl.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

class GameRepositoryImpl: GameRepository {
    private let gameRemoteData: GameRemoteData
    init(remoteData: GameRemoteData) {
        self.gameRemoteData = remoteData
    }
    func fetchGamesData() -> Observable<[ResultGame]> {
        return gameRemoteData
            .fetchGamesData()
    }
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[ResultGame]> {
        return gameRemoteData
            .fetchGamesDataSearch(searchKeyword: searchKeyword)
    }
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailModel> {
        return gameRemoteData
            .fetchGameDetail(idGame: idGame)
    }
}
