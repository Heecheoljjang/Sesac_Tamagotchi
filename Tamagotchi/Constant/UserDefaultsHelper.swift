//
//  UserDefaultsHelper.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    //인스턴스 생성방지
    private init() {}
    
    //인스턴스 생성
    static let shared = UserDefaultsHelper()
    
    let userDefaults = UserDefaults.standard
    
    let domain = Bundle.main.bundleIdentifier!
    
    //userdefaults 키 -> rawValue로 사용
    enum Keys: String {
        case name
        case tamagotchi
        case status
    }
    
    var name: String {
        get {
            return userDefaults.string(forKey: Keys.name.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: Keys.name.rawValue)
        }
    }
    
    var tamagotchi: Data {
        get {
            if let tamaData = userDefaults.object(forKey: Keys.tamagotchi.rawValue) as? Data {
                return tamaData
            }
            return Data()
        }
        set {
            userDefaults.set(newValue, forKey: Keys.tamagotchi.rawValue)
        }
    }
    
    var status: Data {
        get {
            if let statusData = userDefaults.object(forKey: Keys.status.rawValue) as? Data {
                return statusData
            }
            return Data()
        }
        set {
            userDefaults.set(newValue, forKey: Keys.status.rawValue)
        }
    }
    
    func removeAllContents() {
        userDefaults.removePersistentDomain(forName: domain)
    }
}
