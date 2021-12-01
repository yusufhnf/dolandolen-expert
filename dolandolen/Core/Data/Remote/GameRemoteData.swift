//
//  GameRemoteData.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 24/11/21.
//

import Foundation
import RxSwift

protocol GameRemoteData: AnyObject {
    func fetchGamesData() -> Observable<[ResultGame]>
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[ResultGame]>
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailResponse>
}
