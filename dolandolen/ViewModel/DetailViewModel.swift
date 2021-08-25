//
//  DetailViewModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 20/08/21.
//

import Foundation

class DetailViewModel {
    private let apiService: APIServices
    var gameDetailResult: GameDetailModel?
    init(apiService: APIServices = APIServices()) {
        self.apiService = apiService
    }
    func fetchGamesData(idGame: Int, completion: @escaping (Result<GameDetailModel, NetworkErrorHandling>) -> Void) {
        self.apiService.fetchGamesDetail(idGame: idGame) { result in
            switch result {
            case .success(let data):
                self.gameDetailResult = data
                print("hasil: \(String(describing: self.gameDetailResult?.name))")
                completion(.success(data))
            case .failure(let error):
                print("Error processing json data: \(error)")
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
            }
        }
    }
}
