//
//  SceneDelegate.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 11/08/21.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let container: Container = {
        let container = Container()
        container.register(GameRemoteData.self) {_ in
            GameRemoteDataImpl()
        }
        container.register(GameLocalData.self) {_ in
            GameLocalDataImpl()
        }
        container.register(GameRepository.self) { resolver in
            GameRepositoryImpl(
                remoteData: resolver.resolve(GameRemoteData.self)!
            )
        }
        container.register(FavouriteRepository.self) { resolver in
            FavouriteRepositoryImpl(
                localData: resolver.resolve(GameLocalData.self)!
            )
        }
        container.register(HomeUseCase.self) { resolver in
            HomeInteractor(gameRepository: resolver.resolve(GameRepository.self)!)
        }
        container.register(HomePresenter.self) { resolver in
            HomePresenter(homeUseCase: resolver.resolve(HomeUseCase.self)!)
        }
        container.register(HomeViewController.self) { resolver in
            let controller = HomeViewController()
            controller.homePresenter = resolver.resolve(HomePresenter.self)
            return controller
        }
        container.register(SearchUseCase.self) { resolver in
            SearchInteractor(gameRepository: resolver.resolve(GameRepository.self)!)
        }
        container.register(SearchPresenter.self) { resolver in
            SearchPresenter(searchUseCase: resolver.resolve(SearchUseCase.self)!)
        }
        container.register(SearchViewController.self) { resolver in
            let controller = SearchViewController()
            controller.searchPresenter = resolver.resolve(SearchPresenter.self)
            return controller
        }
        container.register(DetailUseCase.self) { resolver in
            DetailInteractor(gameRepository: resolver.resolve(GameRepository.self)!,
                             favouriteRepository: resolver.resolve(FavouriteRepository.self)!)
        }
        container.register(DetailPresenter.self) { resolver in
            DetailPresenter(detailUseCase: resolver.resolve(DetailUseCase.self)!)
        }
        container.register(DetailViewController.self) { resolver in
            let controller = DetailViewController()
            controller.detailPresenter = resolver.resolve(DetailPresenter.self)
            return controller
        }
        container.register(FavouriteUseCase.self) { resolver in
            FavouriteInteractor(favouriteRepository: resolver.resolve(FavouriteRepository.self)!)
        }
        container.register(FavouritePresenter.self) { resolver in
            FavouritePresenter(favouriteUseCase: resolver.resolve(FavouriteUseCase.self)!)
        }
        container.register(FavoritesViewController.self) { resolver in
            let controller = FavoritesViewController()
            controller.favouritePresenter = resolver.resolve(FavouritePresenter.self)
            return controller
        }
        return container
    }()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: TabbarViewController())
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    func sceneWillResignActive(_ scene: UIScene) {
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
