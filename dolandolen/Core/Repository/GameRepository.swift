//
//  GameRepository.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

protocol GameRepository: AnyObject {
    func fetchGamesData() -> Observable<[ResultGame]>
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[ResultGame]>
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailModel>
}
