//
//  HomePresenter.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

class HomePresenter {
    private let disposeBag = DisposeBag()
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    var gamesData = PublishSubject<[ResultGame]>()
    var errorMessage = PublishSubject<String>()
    var activityIndicator = PublishSubject<Bool>()
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    func fetchGame() {
        self.activityIndicator.onNext(true)
        homeUseCase.fetchGamesData()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gamesData.onNext(result)
            } onError: { error in
                self.errorMessage.onNext(error.localizedDescription)
            } onCompleted: {
                self.activityIndicator.onNext(false)
            }.disposed(by: disposeBag)
    }
    func navigateToDetail(navigationController: UINavigationController?, idGame: Int) {
        navigationController?.pushViewController(router.detailRoute(idGame: idGame), animated: true)
    }
}
