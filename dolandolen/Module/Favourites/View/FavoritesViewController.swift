//
//  FavoritesViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import UIKit
import RxSwift
import Game
import GameFavourite
import Core

class FavoritesViewController: UIViewController {
    var disposeBag = DisposeBag()
    var gameFavouritesResult = [GameModel]()
    private var favouriteTable = UITableView()
    var presenter: ListingPresenter
    < String,
      GameModel,
      Interactor < String,
                   [GameModel],
                   GetFavouritesDataRepository < GameFavouriteLocalData, GameFavouriteTransformer > > >?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "favourite_label".localized()
        view.addSubview(favouriteTable)
        favouriteTable.isHidden = true
        bindSubcriber()
    }
    
    private func setupTableView() {
        favouriteTable.dataSource = self
        favouriteTable.delegate = self
        favouriteTable.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        favouriteTable.translatesAutoresizingMaskIntoConstraints = false
        favouriteTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favouriteTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        favouriteTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        favouriteTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    private func loadGameFavouritesData(name: String? = nil) {
        presenter?.getList(request: name)
    }
    
    private func bindSubcriber() {
        presenter?.list.subscribe(
            onNext: { games in
                self.gameFavouritesResult = games
                print(games)
                self.favouriteTable.isHidden = false
                self.favouriteTable.reloadData()
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
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        setupTableView()
        loadGameFavouritesData()
    }
}

extension FavoritesViewController: UITableViewDelegate {
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameFavouritesResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
        as? GameTableViewCell ?? GameTableViewCell()
        let gameData = self.gameFavouritesResult[indexPath.row]
        gameCell.gameTitleText.text = gameData.name
        gameCell.gameSubtitleText.text = "⭐️ \(gameData.rating)"
        gameCell.gameReleaseText.text = "🗓 \(gameData.releasedDateText)"
        gameCell.gameImageView.kf.setImage(with: URL(string: gameData.backgroundImage ?? ""),
                                           placeholder: UIImage(named: "placeholder"))
        return gameCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = HomeRouter.pushToDetailView(idGame: gameFavouritesResult[indexPath.row].idGame)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
