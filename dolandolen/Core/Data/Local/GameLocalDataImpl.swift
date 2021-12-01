//
//  GameLocalDataImpl.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 27/11/21.
//

import Foundation
import CoreData
import RxSwift

class GameLocalDataImpl: GameLocalData {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameCoreDataModel")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Error on: \(error?.localizedDescription ?? "Undefined")")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.undoManager = nil
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        return container
    }()
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return taskContext
    }
    func getFavouritesData() -> Observable<[GameFavoriteEntity]> {
        return Observable<[GameFavoriteEntity]>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
                do {
                    let results = try taskContext.fetch(fetchRequest)
                    var games: [GameFavoriteEntity] = []
                    for result in results {
                        let gamesData = GameFavoriteEntity(
                            idGame: result.value(forKey: "idGame") as? Int32,
                            name: result.value(forKey: "name") as? String,
                            description: result.value(forKey: "desc") as? String,
                            backgroundImage: result.value(forKey: "backgroundImage")
                            as? String,
                            rating: result.value(forKey: "rating") as? Double,
                            ratingTop: result.value(forKey: "ratingTop") as? Int32,
                            releaseDate: result.value(forKey: "releaseDate") as? String)
                        games.append(gamesData)
                    }
                    observer.onNext(games)
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(CoreDataError.requestFailed(error as? String ?? "undefined"))
                }
            }
            return Disposables.create()
        }
    }
    func getFavouriteGameDetail(idGame: Int) -> Observable<GameFavoriteEntity> {
        return Observable<GameFavoriteEntity>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(idGame)")
                do {
                    if let result = try taskContext.fetch(fetchRequest).first {
                        let gameData = GameFavoriteEntity(
                            idGame: result.value(forKey: "idGame") as? Int32,
                            name: result.value(forKey: "name") as? String,
                            description: result.value(forKey: "desc") as? String,
                            backgroundImage: result.value(forKey: "backgroundImage")
                            as? String,
                            rating: result.value(forKey: "rating") as? Double,
                            ratingTop: result.value(forKey: "ratingTop") as? Int32,
                            releaseDate: result.value(forKey: "releaseDate") as? String)
                        observer.onNext(gameData)
                        observer.onCompleted()
                    }
                } catch let error as NSError {
                    observer.onError(CoreDataError.requestFailed(error as? String ?? "undefined"))
                }
            }
            return Disposables.create()
        }
    }
    func addFavouriteGame(gameData: GameDetailModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.performAndWait {
                if let entity = NSEntityDescription.entity(forEntityName: "Favourites", in: taskContext) {
                    let game = NSManagedObject(entity: entity, insertInto: taskContext)
                    game.setValue(gameData.idGame, forKey: "idGame")
                    game.setValue(gameData.name, forKey: "name")
                    game.setValue(gameData.rating, forKey: "rating")
                    game.setValue(gameData.backgroundImage, forKey: "backgroundImage")
                    game.setValue(gameData.released, forKey: "releaseDate")
                    game.setValue(gameData.gameDetailModelDescription, forKey: "desc")
                    game.setValue(gameData.ratingTop, forKey: "ratingTop")
                    do {
                        try taskContext.save()
                        observer.onNext(true)
                        observer.onCompleted()
                    } catch let error as NSError {
                        observer.onError(CoreDataError.requestFailed(error as? String ?? "undefined"))
                    }
                }
            }
            return Disposables.create()
        }
    }
    func isFavoritedGame(idGame: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "idGame == \(idGame)")
                do {
                    if (try taskContext.fetch(fetchRequest).first) != nil {
                        observer.onNext(true)
                    } else {
                        observer.onNext(false)
                    }
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(CoreDataError.requestFailed(error as? String ?? "undefined"))
                }
            }
            return Disposables.create()
        }
    }
    func deleteFavouriteGame(idGame: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "idGame == \(idGame)")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                   batchDeleteResult.result != nil {
                    observer.onNext(true)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
