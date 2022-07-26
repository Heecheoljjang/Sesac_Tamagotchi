//
//  Status.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/23.
//

import UIKit

//struct Status: Codable {
//    var level: Int
//    var food: Int
//    var water: Int
//}

struct Status: Codable {
    
    var food: Int
    var water: Int
    var typeNumber: String = "0" // 다마고치별 이미지 앞 숫자
    
    var level: Int {
        get {
            let exp = (Double(food) / 5) + (Double(water) / 2)
            switch exp {
            case 0..<20 :
                return 1
            case 20..<30 :
                return 2
            case 30..<40 :
                return 3
            case 40..<50 :
                return 4
            case 50..<60 :
                return 5
            case 60..<70 :
                return 6
            case 70..<80 :
                return 7
            case 80..<90 :
                return 8
            case 90..<100 :
                return 9
            case 100... :
                return 10
            default:
                return 0
            }
        }
    }
    
    var statusLabel: String {
        get {
            return "LV\(level) · 밥알 \(food)개 · 물방울 \(water)개"
        }
    }
    
    var profileImg: String {
        get {
            return typeNumber + "-\(level)"
        }
        set {
            typeNumber = newValue
        }
    }
}
