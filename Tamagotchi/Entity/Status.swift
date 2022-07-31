//
//  Status.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/23.
//

import UIKit

struct Status: Codable {
    
    var food = 0
    var water = 0
    var typeNumber = "0" // 다마고치별 이미지 앞 숫자
    
    var level: Int {
        get {
            let exp = (Double(food) / 5) + (Double(water) / 2)
            
            if exp >= 0 && exp < 20 {
                print(exp, "1")
                return 1
            } else if exp >= 100 {
                print(exp, "10")
                return 10
            } else {
                return Int(exp / 10)
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
            if level < 10 && level >= 1 {
                return typeNumber + "-\(level)"
            } else if level >= 10 {
                return typeNumber + "-9"
            } else {
                return "noImage"
            }
        }
        set {
            typeNumber = newValue
        }
    }
}
