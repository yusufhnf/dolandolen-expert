//
//  FavouriteRepository.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

protocol FavouriteRepository: AnyObject {
    func getFavouritesData() -> Observable<[GameModel]>
    func addFavouriteGame(gameData: GameDetailModel) -> Observable<Bool>
    func isFavoritedGame(idGame: Int) -> Observable<Bool>
    func deleteFavouriteGame(idGame: Int) -> Observable<Bool>
}
