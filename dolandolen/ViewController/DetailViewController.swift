//
//  DetailViewController.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 22/08/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageGameText: UIImageView!
    @IBOutlet weak var titleGameText: UILabel!
    @IBOutlet weak var ratingGameText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descGameText: UILabel!
    var idGame: Int?
    private let viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        getGameDetail()
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
    private func updateTableUI(_ item: GameDetailModel) {
        titleGameText.text = item.name
        ratingGameText.text = "⭐️ \(String(describing: item.rating))"
        descGameText.text = item.gameDetailModelDescription
        imageGameText.kf.setImage(with: URL(string: item.backgroundImage ?? ""),
                                  placeholder: UIImage(named: "placeholder"))
    }

}
