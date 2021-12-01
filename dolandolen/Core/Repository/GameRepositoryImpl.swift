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
    func fetchGamesData() -> Observable<[GameModel]> {
        return gameRemoteData
            .fetchGamesData()
            .map {GameMapper.mapGameResponseToDomain(input: $0)}
    }
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[GameModel]> {
        return gameRemoteData
            .fetchGamesDataSearch(searchKeyword: searchKeyword)
            .map {GameMapper.mapGameResponseToDomain(input: $0)}
    }
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailModel> {
        return gameRemoteData
            .fetchGameDetail(idGame: idGame)
            .map {GameMapper.mapGameDetailResponseToDomain(input: $0)}
    }
}
