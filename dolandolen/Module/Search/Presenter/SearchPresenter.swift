//
//  SearchPresenter.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 28/11/21.
//

import Foundation
import RxSwift

class SearchPresenter {
    private let disposeBag = DisposeBag()
    private let router = SearchRouter()
    private let searchUseCase: SearchUseCase
    var gamesData = PublishSubject<[GameModel]>()
    var errorMessage = PublishSubject<String>()
    var activityIndicator = PublishSubject<Bool>()
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
    func fetchGame(searchKeyword: String?) {
        self.activityIndicator.onNext(true)
        searchUseCase.fetchGamesDataSearch(searchKeyword: searchKeyword)
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
