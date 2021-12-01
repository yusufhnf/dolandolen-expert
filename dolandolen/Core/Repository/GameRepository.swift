//
//  GameRepository.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

protocol GameRepository: AnyObject {
    func fetchGamesData() -> Observable<[GameModel]>
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[GameModel]>
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailModel>
}
