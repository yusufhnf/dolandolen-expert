//
//  NetworkErrorHandling.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 20/08/21.
//

import Foundation

enum NetworkErrorHandling: Error, CustomNSError {
    case networkError
    case apiError
    case decodingError
    var localizedDescription: String {
        switch self {
        case .apiError: return "Gagal mengambil data dari server"
        case .networkError: return "Tidak ada koneksi internet"
        case .decodingError: return "Gagal untuk decode data"
        }
    }
}
