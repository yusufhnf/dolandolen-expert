//
//  SearchViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 23/08/21.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate {
    private let viewModel = SearchViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private let gameTable = UITableView()
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableConfig()
        view.addSubview(gameTable)
        setupTableView()
        setupNavigationBar()
        searchBarSetup()
    }
    private func searchBarSetup() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        searchController.searchBar.delegate = self
        let textFieldSearchbar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldSearchbar?.placeholder = "Cari game"
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let position = searchController.searchBar.text {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: { (_) in
                self.getGameDataSearch(searchValue: position)
            })
            removeActivityIndicator()
        }
    }
    private func getGameDataSearch(searchValue: String) {
        self.showActivityIndicator()
        viewModel.fetchGamesSearchData(value: searchValue) { [weak self] (result) in
            switch result {
            case .success(let data):
                print(data)
                self?.updateTableUI()
                self?.removeActivityIndicator()
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.removeActivityIndicator()
                }
                print("Error on: \(error.localizedDescription)")
            }
        }
    }
    func showConnectionAlert() {
        let alert = UIAlertController(title: "Koneksi Internet Bermasalah",
            message: "Pastikan perangkatmu tersambung ke Internet", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            print("oke")
        }))
        self.present(alert, animated: true)
    }
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Cari"
        self.navigationItem.searchController = searchController
    }
    private func setupTableConfig() {
        gameTable.dataSource = self
        gameTable.delegate = self
        gameTable.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
    }
    private func setupTableView() {
        gameTable.translatesAutoresizingMaskIntoConstraints = false
        gameTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gameTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        gameTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        gameTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    private func updateTableUI() {
        DispatchQueue.main.async {
            self.gameTable.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
}

extension SearchViewController: UITableViewDelegate {
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gameSearchResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
            as? GameTableViewCell ?? GameTableViewCell()
        let gameData = viewModel.gameSearchResult[indexPath.row]
        gameCell.gameTitleText.text = gameData.name
        gameCell.gameSubtitleText.text = "⭐️ \(gameData.rating)"
        gameCell.gameImageView.kf.setImage(with: URL(string: gameData.backgroundImage ?? ""),
                                           placeholder: UIImage(named: "placeholder"))
        gameCell.gameReleaseText.text = "🗓 \(gameData.dateText)"
        return gameCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailView.idGame = viewModel.gameSearchResult[indexPath.row].idGame
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
