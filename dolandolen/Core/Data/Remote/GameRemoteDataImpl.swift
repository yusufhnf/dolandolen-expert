//
//  GameRemoteDataImpl.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 27/11/21.
//

import Foundation
import RxSwift
import Alamofire

class GameRemoteDataImpl: GameRemoteData {
    func fetchGamesData() -> Observable<[ResultGame]> {
        return Observable<[ResultGame]>.create {observer in
            if let url = URL(string: Endpoints.Gets.gameList.url) {
                let parameters = ["key": API.apiKey]
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    func fetchGamesDataSearch(searchKeyword: String?) -> Observable<[ResultGame]> {
        return Observable<[ResultGame]>.create {observer in
            if let url = URL(string: Endpoints.Gets.gameList.url) {
                var parameters = ["key": API.apiKey]
                if let getSearchKeyword = searchKeyword {
                    parameters["search"] = getSearchKeyword
                }
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    func fetchGameDetail(idGame: Int) -> Observable<GameDetailResponse> {
        return Observable<GameDetailResponse>.create {observer in
            if let url = URL(string: "\(Endpoints.Gets.gameDetail.url)\(idGame)") {
                let parameter = ["key": API.apiKey]
                AF.request(url, parameters: parameter)
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
