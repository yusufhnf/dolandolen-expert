//
//  FavouriteRouter.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 29/11/21.
//

import Foundation
import UIKit

class FavouriteRouter {
    let scene = UIApplication.shared.connectedScenes.first
    func detailRoute(idGame: Int) -> DetailViewController {
        var detailVC: DetailViewController?
        if let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate) {
            detailVC = sceneDelegate.container.resolve(DetailViewController.self)
        }
        detailVC?.idGame = idGame
        return detailVC ?? DetailViewController()
    }
}
