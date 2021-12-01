//
//  FavouritePresenter.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 29/11/21.
//

import Foundation
import RxSwift

class FavouritePresenter {
    private let disposeBag = DisposeBag()
    private let router = FavouriteRouter()
    private let favouriteUseCase: FavouriteUseCase
    var gamesFavouriteData = PublishSubject<[GameModel]>()
    var errorMessage = PublishSubject<String>()
    var activityIndicator = PublishSubject<Bool>()
    init(favouriteUseCase: FavouriteUseCase) {
        self.favouriteUseCase = favouriteUseCase
    }
    func getFavouriteGame() {
        favouriteUseCase.getFavouritesData()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gamesFavouriteData.onNext(result)
            } onError: { error in
                self.errorMessage.onNext(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    func navigateToDetail(navigationController: UINavigationController?, idGame: Int) {
        navigationController?.pushViewController(router.detailRoute(idGame: idGame), animated: true)
    }
}
