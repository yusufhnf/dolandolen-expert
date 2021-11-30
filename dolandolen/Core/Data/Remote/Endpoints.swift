//
//  Endpoints.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 27/11/21.
//

import Foundation

struct API {
    static let baseURL = "https://api.rawg.io/api"
    static let apiKey = Bundle.main.infoDictionary?["RAWG_API_KEY"] as? String
}
protocol Endpoint {
    var url: String {get}
}
enum Endpoints {
    enum Gets: Endpoint {
        case gameList
        case gameDetail
        public var url: String {
            switch self {
            case .gameList:
                return "\(API.baseURL)/games"
            case .gameDetail:
                return "\(API.baseURL)/games/"
            }
        }
    }
}
