//
//  GameProvider.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import CoreData

class GameProvider {
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
    func getFavouritesData(completion: @escaping(Result<[GameFavoriteModel], Error>) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameFavoriteModel] = []
                for result in results {
                    let gamesData = GameFavoriteModel(idGame: result.value(forKey: "idGame") as? Int32,
                                                      name: result.value(forKey: "name") as? String,
                                                      description: result.value(forKey: "desc") as? String,
                                                      backgroundImage: result.value(forKey: "backgroundImage") as? String,
                                                      rating: result.value(forKey: "rating") as? Double,
                                                      ratingTop: result.value(forKey: "ratingTop") as? Int32,
                                                      releaseDate: result.value(forKey: "releaseDate") as? String)
                    games.append(gamesData)
                }
                completion(.success(games))
            } catch let error as NSError {
                print("Couldn't fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func getFavouriteGameDetail(_ idGame: Int, completion: @escaping(_ fav: GameFavoriteModel) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(idGame)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let gameData = GameFavoriteModel(idGame: result.value(forKey: "idGame") as? Int32,
                                                     name: result.value(forKey: "name") as? String,
                                                     description: result.value(forKey: "desc") as? String,
                                                     backgroundImage: result.value(forKey: "backgroundImage") as? String,
                                                     rating: result.value(forKey: "rating") as? Double,
                                                     ratingTop: result.value(forKey: "ratingTop") as? Int32,
                                                     releaseDate: result.value(forKey: "releaseDate") as? String)
                    completion(gameData)
                }
            } catch let error as NSError {
                print("Couldn't fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func addFavouriteGame(gameData: GameFavoriteModel, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favourites", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(gameData.idGame, forKey: "idGame")
                game.setValue(gameData.name, forKey: "name")
                game.setValue(gameData.rating, forKey: "rating")
                game.setValue(gameData.backgroundImage, forKey: "backgroundImage")
                game.setValue(gameData.releaseDate, forKey: "releaseDate")
                game.setValue(gameData.description, forKey: "desc")
                game.setValue(gameData.ratingTop, forKey: "ratingTop")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    func isFavoritedGame(_ idGame: Int,
                         completion: @escaping(_ isFavourite: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourites")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "idGame == \(idGame)")
            do {
                if (try taskContext.fetch(fetchRequest).first) != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func deleteFavouriteGame(_ idGame: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourites")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "idGame == \(idGame)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
               batchDeleteResult.result != nil {
                completion()
            }
        }
    }
}
