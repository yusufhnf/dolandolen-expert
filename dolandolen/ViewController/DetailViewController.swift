//
//  DetailViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 22/08/21.
//

import UIKit
import Toast

class DetailViewController: UIViewController {
    @IBOutlet weak var imageGameText: UIImageView!
    @IBOutlet weak var titleGameText: UILabel!
    @IBOutlet weak var ratingGameText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descGameText: UILabel!
    var idGame: Int?
    private let viewModel = DetailViewModel()
    private lazy var gameProvider: GameProvider = { return GameProvider() }()
    private lazy var favouriteButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),
                                  style: .plain, target: self, action: #selector(self.onButtonFavClicked))
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
        isGameFavourited()
        setIconFavourite()
    }
    override func viewWillLayoutSubviews() {
        setIconFavourite()
    }
    @objc private func onButtonFavClicked() {
        if viewModel.isFavourited {
            guard let idGame = idGame else { return }
            removeGameFavourite(idGame)
        } else {
            addToFavouriteGame()
        }
        viewModel.isFavourited = !viewModel.isFavourited
        setIconFavourite()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    private func getGameDetail() {
        guard let getIdGame = idGame else { return }
        showActivityIndicator()
        viewModel.fetchGamesData(idGame: getIdGame) { (result) in
            switch result {
            case .success(let data):
                self.scrollView.isHidden = false
                self.updateTableUI(data)
                self.removeActivityIndicator()
            case .failure(let error):
                self.removeActivityIndicator()
                print("Error on: \(error.localizedDescription)")
            }
        }
    }
    private func isGameFavourited() {
        guard let idGame = idGame else { return }
        gameProvider.isFavoritedGame(idGame) { (isGameAsFavourite) in
            self.viewModel.isFavourited = isGameAsFavourite
            DispatchQueue.main.async { self.setIconFavourite() }
        }
    }
    private func setIconFavourite() {
        if viewModel.isFavourited {
            navigationItem.rightBarButtonItem = favouriteButton
        } else {
            navigationItem.rightBarButtonItem = unfavouriteButton
        }
    }
    private func updateTableUI(_ item: GameDetailModel) {
        titleGameText.text = item.name
        ratingGameText.text = "⭐️ \(String(describing: item.rating))"
        descGameText.text = item.gameDetailModelDescription
        imageGameText.kf.setImage(with: URL(string: item.backgroundImage ?? ""),
                                  placeholder: UIImage(named: "placeholder"))
    }
    private func addToFavouriteGame() {
        guard let idGame = idGame else { return }
        let name = viewModel.gameDetailResult?.name ?? ""
        let rating = viewModel.gameDetailResult?.rating ?? 0.0
        let releaseDate = viewModel.gameDetailResult?.released ?? ""
        let description = viewModel.gameDetailResult?.gameDetailModelDescription ?? ""
        let image = viewModel.gameDetailResult?.backgroundImage ?? ""
        let ratingTop = viewModel.gameDetailResult?.ratingTop ?? 0
        gameProvider.addFavouriteGame(gameData: GameFavoriteModel(idGame: Int32(idGame),
                                                                  name: name,
                                                                  description: description,
                                                                  backgroundImage: image,
                                                                  rating: rating,
                                                                  ratingTop: Int32(ratingTop),
                                                                  releaseDate: releaseDate)) {
            DispatchQueue.main.async {
                self.view.makeToast("berhasil menambahkan ke daftar favorit")
            }
        }
    }
    private func removeGameFavourite(_ idGame: Int) {
        gameProvider.deleteFavouriteGame(idGame) {
            DispatchQueue.main.async {
                self.view.makeToast("berhasil menghapus favorit")
            }
        }
    }

}
