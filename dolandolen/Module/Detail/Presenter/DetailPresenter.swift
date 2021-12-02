//
//  DetailPresenter.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

class DetailPresenter {
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCase
    var gameDetailData = PublishSubject<GameDetailModel>()
    var addGameFavourite = PublishSubject<Bool>()
    var removeGameFavourite = PublishSubject<Bool>()
    var isGameFavorite = PublishSubject<Bool>()
    var errorMessage = PublishSubject<String>()
    var activityIndicator = PublishSubject<Bool>()
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    func fetchGame(idGame: Int) {
        self.activityIndicator.onNext(true)
        detailUseCase.fetchGameDetail(idGame: idGame)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gameDetailData.onNext(result)
            } onError: { error in
                self.errorMessage.onNext(error.localizedDescription)
            } onCompleted: {
                self.activityIndicator.onNext(false)
            }.disposed(by: disposeBag)
    }
    func addGameToFavourite(gameData: GameFavoriteEntity) {
        self.activityIndicator.onNext(true)
        detailUseCase.addFavouriteGame(gameData: gameData)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.addGameFavourite.onNext(result)
            } onError: { error in
                self.errorMessage.onNext(error.localizedDescription)
            } onCompleted: {
                self.activityIndicator.onNext(false)
            }.disposed(by: disposeBag)
    }
    func removeGameToFavourite(idGame: Int) {
        self.activityIndicator.onNext(true)
        detailUseCase.deleteFavouriteGame(idGame: idGame)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.removeGameFavourite.onNext(result)
            } onError: { error in
                self.errorMessage.onNext(error.localizedDescription)
            } onCompleted: {
                self.activityIndicator.onNext(false)
            }.disposed(by: disposeBag)
    }
    func isGameFavourited(idGame: Int) {
        detailUseCase.isFavoritedGame(idGame: idGame)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.isGameFavorite.onNext(result)
            } onError: { error in
                self.errorMessage.onNext(error.localizedDescription)
            } .disposed(by: disposeBag)
    }
}
