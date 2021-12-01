//
//  UserModel.swift
//  dolandolen
//
//  Created by Yusuf Umar Hanafi on 26/08/21.
//

import Foundation

class UserEntity {
    static let nameKey = "name"
    static let descKey = "desc"
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? "Yusuf Umar Hanafi"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
    static var desc: String {
        get {
            return UserDefaults.standard.string(forKey: descKey) ?? "iOS Developer | Apple Developer Academy"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: descKey)
        }
    }
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
