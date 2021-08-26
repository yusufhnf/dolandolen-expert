//
//  HomeViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 11/08/21.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()
    private let gameTable = UITableView()
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(gameTable)
        setupTableView()
        setupNavigationBar()
        if NetworkMonitor.shared.isConnected {
            print("Connected")
            getGameData()
        } else {
            print("Not Connected")
            showConnectionAlert()
        }
    }
    private func getGameData() {
        self.showActivityIndicator()
        viewModel.fetchGamesData { [weak self] (result) in
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
        self.navigationItem.title = "DolanDolen"
    }
    private func setupTableView() {
        gameTable.dataSource = self
        gameTable.delegate = self
        gameTable.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
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

extension HomeViewController: UITableViewDelegate {
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gameResult.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameCell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
            as? GameTableViewCell ?? GameTableViewCell()
        let gameData = viewModel.gameResult[indexPath.row]
        let formatter = Formatter()
        gameCell.gameTitleText.text = gameData.name
        gameCell.gameSubtitleText.text = "⭐️ \(gameData.rating)"
        gameCell.gameReleaseText.text = "🗓 \(formatter.dateFormatter(dateValue: gameData.released))"
        gameCell.gameImageView.kf.setImage(with: URL(string: gameData.backgroundImage ?? ""),
                                           placeholder: UIImage(named: "placeholder"))
        return gameCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailView.idGame = viewModel.gameResult[indexPath.row].idGame
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
