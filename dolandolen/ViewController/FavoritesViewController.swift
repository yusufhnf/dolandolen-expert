//
//  FavoritesViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    private var viewModel = FavoritesViewModel()
    private var favouriteTable = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorit"
        view.addSubview(favouriteTable)
        favouriteTable.isHidden = true
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
    private func loadGameFavouritesData() {
        self.showActivityIndicator()
        viewModel.loadFavouriteData { [weak self] (result) in
            switch result {
            case .success(let data):
                print(data)
                self?.updateTableUI()
                self?.removeActivityIndicator()
            case .failure(let error):
                self?.removeActivityIndicator()
                print("Error on: \(error.localizedDescription)")
            }
        }
    }
    private func updateTableUI() {
        DispatchQueue.main.async {
            self.favouriteTable.isHidden = false
            self.favouriteTable.reloadData()
        }
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
        return viewModel.gameFavouritesResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
            as? GameTableViewCell ?? GameTableViewCell()
        let gameData = viewModel.gameFavouritesResult[indexPath.row]
        let formatter = Formatter()
        gameCell.gameTitleText.text = gameData.name
        gameCell.gameSubtitleText.text = "⭐️ \(gameData.rating ?? 0.0)"
        gameCell.gameReleaseText.text = "🗓 \(formatter.dateFormatter(dateValue: gameData.releaseDate))"
        gameCell.gameImageView.kf.setImage(with: URL(string: gameData.backgroundImage ?? ""),
                                           placeholder: UIImage(named: "placeholder"))
        return gameCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailView.idGame = Int(viewModel.gameFavouritesResult[indexPath.row].idGame ?? 1)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
