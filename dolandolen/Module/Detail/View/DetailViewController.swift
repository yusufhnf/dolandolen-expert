//
//  DetailViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 22/08/21.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    @IBOutlet weak var imageGameText: UIImageView!
    @IBOutlet weak var titleGameText: UILabel!
    @IBOutlet weak var ratingGameText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descGameText: UILabel!
    var idGame: Int?
    var detailPresenter: DetailPresenter?
    var gameDetailResult: GameDetailModel?
    var disposeBag = DisposeBag()
    private lazy var favouriteButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),
                                  style: .plain, target: self, action: #selector(self.onButtonUnfavouriteClicked))
        btn.tintColor = .systemRed
        return btn
    }()
    private lazy var unfavouriteButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "heart"),
                                  style: .plain, target: self, action: #selector(self.onButtonFavClicked))
        btn.tintColor = .systemRed
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        getGameDetail()
    }
    @objc private func onButtonFavClicked() {
        if let gameData = self.gameDetailResult {
            detailPresenter?.addGameToFavourite(gameData: gameData)
        }
    }
    @objc private func onButtonUnfavouriteClicked() {
        if let gameData = self.gameDetailResult {
            detailPresenter?.removeGameToFavourite(idGame: gameData.idGame)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        if let gameId = idGame {
            detailPresenter?.fetchGame(idGame: gameId)
            detailPresenter?.isGameFavourited(idGame: gameId)
        }
    }
    private func getGameDetail() {
        detailPresenter?.gameDetailData.subscribe(
            onNext: { game in
                self.gameDetailResult = game
                self.updateTableUI(game)
            }
        ).disposed(by: disposeBag)
        detailPresenter?.activityIndicator.subscribe(
            onNext: { status in
                if status {
                    self.showActivityIndicator()
                } else {
                    self.removeActivityIndicator()
                }
            }
        ).disposed(by: disposeBag)
        detailPresenter?.errorMessage.subscribe(
            onNext: { message in
                print("error message:\(message)")
            }).disposed(by: disposeBag)
        detailPresenter?.addGameFavourite.subscribe(
            onNext: { status in
                if status {
                    self.navigationItem.rightBarButtonItem = self.favouriteButton
                }
            }).disposed(by: disposeBag)
        detailPresenter?.removeGameFavourite.subscribe(
            onNext: { status in
                if status {
                    self.navigationItem.rightBarButtonItem = self.unfavouriteButton
                }
            }).disposed(by: disposeBag)
        detailPresenter?.isGameFavorite.subscribe(
            onNext: { isFavorite in
                if isFavorite {
                    self.navigationItem.rightBarButtonItem = self.favouriteButton
                } else {
                    self.navigationItem.rightBarButtonItem = self.unfavouriteButton
                }
            }).disposed(by: disposeBag)
    }
    private func updateTableUI(_ item: GameDetailModel) {
        titleGameText.text = item.name
        ratingGameText.text = "⭐️ \(String(describing: item.rating))"
        descGameText.text = item.gameDetailModelDescription
        imageGameText.kf.setImage(with: URL(string: item.backgroundImage ?? ""),
                                  placeholder: UIImage(named: "placeholder"))
        self.scrollView.isHidden = false
    }
}
