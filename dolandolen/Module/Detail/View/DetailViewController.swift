//
//  DetailViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 22/08/21.
//

import UIKit
import RxSwift
import Game
import Core
import GameFavourite

class DetailViewController: UIViewController {
    @IBOutlet weak var imageGameText: UIImageView!
    @IBOutlet weak var titleGameText: UILabel!
    @IBOutlet weak var ratingGameText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descGameText: UILabel!
    var idGame: Int?
    var gameDetailResult: GameDetailModel?
    var disposeBag = DisposeBag()
    
    var presenter: GameDetailPresenter<
        Interactor<String, GameDetailModel, GameDetailRepository< GameDetailRemoteDataSource, GameDetailTransformer>>,
        Interactor<GameDetailModel, Bool, AddFavouriteGameRepository< GameFavouriteLocalData, AddGameFavouriteTransformer>>,
        Interactor<String, Bool, DeleteFavouriteGameRepository< GameFavouriteLocalData>>,
        Interactor<String, Bool, StatusFavouriteGameRepository< GameFavouriteLocalData>>
    >?
    
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
        self.navigationItem.setRightBarButton( self.favouriteButton, animated: true)
        bindSubcriber()
    }
    
    @objc private func onButtonFavClicked() {
        if let gameData = self.gameDetailResult {
            presenter?.addFavouriteGame(request: GameDetailModel(
                idGame: gameData.idGame,
                name: gameData.name,
                gameDetailModelDescription: gameData.gameDetailModelDescription,
                backgroundImage: gameData.backgroundImage,
                rating: gameData.rating,
                ratingTop: gameData.ratingTop ?? 0,
                released: gameData.released))
        }
    }
    
    @objc private func onButtonUnfavouriteClicked() {
        if let gameData = self.gameDetailResult {
            presenter?.removeFavouriteGame(request: "\(gameData.idGame)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        if let gameId = idGame {
            presenter?.getGameDetail(request: "\(gameId)")
            presenter?.statusFavouriteGame(request: "\(gameId)")
        }
    }
    
    private func bindSubcriber() {
        presenter?.gameDetail.subscribe(
            onNext: { game in
                self.gameDetailResult = game
                self.updateTableUI(game)
            }
        ).disposed(by: disposeBag)
        presenter?.activityIndicatorState.subscribe(
            onNext: { status in
                if status {
                    self.showActivityIndicator()
                } else {
                    self.removeActivityIndicator()
                }
            }
        ).disposed(by: disposeBag)
        presenter?.errorMessage.subscribe(
            onNext: { message in
                print("error message:\(message)")
            }).disposed(by: disposeBag)
        presenter?.addGameFavourite.subscribe(
            onNext: { status in
                if status {
                    self.navigationItem.rightBarButtonItem = self.favouriteButton
                }
            }).disposed(by: disposeBag)
        presenter?.removeGameFavourite.subscribe(
            onNext: { status in
                if status {
                    self.navigationItem.rightBarButtonItem = self.unfavouriteButton
                }
            }).disposed(by: disposeBag)
        presenter?.statusFavourite.subscribe(
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
