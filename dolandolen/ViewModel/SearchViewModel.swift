//
//  SearchViewModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 23/08/21.
//

import Foundation

class SearchViewModel {
    private let apiService: APIServices
    var gameSearchResult = [ResultGame]()
    init(apiService: APIServices = APIServices()) {
        self.apiService = apiService
    }
    func fetchGamesSearchData(value: String, completion:
        @escaping (Result<[ResultGame], NetworkErrorHandling>) -> Void) {
        self.apiService.fetchGamesDataSearch(search: value) { result in
            switch result {
            case .success(let listOf):
                self.gameSearchResult = listOf.results
                completion(.success(listOf.results))
            case .failure(let error):
                print("Error processinng json data: \(error)")
                completion(.failure(error as? NetworkErrorHandling ?? .apiError))
            }
        }
    }
}
