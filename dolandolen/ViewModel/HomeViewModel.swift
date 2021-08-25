//
//  HomeViewModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 19/08/21.
//

import Foundation

class HomeViewModel {
    private let apiService: APIServices
    var gameResult = [ResultGame]()
    init(apiService: APIServices = APIServices()) {
        self.apiService = apiService
    }
    func fetchGamesData(completion: @escaping (Result<[ResultGame], NetworkErrorHandling>) -> Void) {
        self.apiService.fetchGamesData { result in
            switch result {
            case .success(let data):
                self.gameResult = data.results
                completion(.success(data.results))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
            }
        }
    }
}
