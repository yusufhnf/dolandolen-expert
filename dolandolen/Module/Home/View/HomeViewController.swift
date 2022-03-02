//
//  HomeViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 11/08/21.
//

import UIKit
import Kingfisher
import RxSwift
import Game
import Core
import Common

class HomeViewController: UIViewController {
    private let gameTable = UITableView()
    var timer: Timer?
    var disposeBag = DisposeBag()
    var gameResult = [GameModel]()
    var presenter: ListingPresenter < String,
                                      GameModel,
                                      Interactor < String, [GameModel], GameRepository < GameRemoteDataSource, GameTransformer >>>?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        bindSubcriber()
        getGameData(name: nil)
    }
    
    private func getGameData(name: String? = nil) {
        presenter?.getList(request: name)
    }
    
    private func bindSubcriber() {
        presenter?.list.subscribe(
            onNext: { games in
                self.gameResult = games
                self.gameTable.reloadData()
            }
        ).disposed(by: disposeBag)
        presenter?.activityIndicatorState.subscribe(
            onNext: { status in
                if status {
                    self.showActivityIndicator()
                } else {
                    self.removeActivityIndicator()
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "app_title".localized()
    }
    
    private func setupTableView() {
        view.addSubview(gameTable)
        gameTable.dataSource = self
        gameTable.delegate = self
        gameTable.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        gameTable.translatesAutoresizingMaskIntoConstraints = false
        gameTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gameTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        gameTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gameTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
}

extension HomeViewController: UITableViewDelegate {
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        as? GameTableViewCell ?? GameTableViewCell()
        let gameData = self.gameResult[indexPath.row]
        gameCell.gameTitleText.text = gameData.name
        gameCell.gameSubtitleText.text = "⭐️ \(gameData.rating)"
        gameCell.gameReleaseText.text = "🗓 \(gameData.releasedDateText)"
        gameCell.gameImageView.kf.setImage(with: URL(string: gameData.backgroundImage ?? ""),
                                           placeholder: UIImage(named: "placeholder"))
        return gameCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = HomeRouter.pushToDetailView(idGame: gameResult[indexPath.row].idGame)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
