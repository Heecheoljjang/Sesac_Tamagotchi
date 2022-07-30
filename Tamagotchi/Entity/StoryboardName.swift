//
//  Scene.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/31.
//

import Foundation

enum Storyboard {
    case select, detail, main, setting, name
    
    var storyboardName: String {
        get {
            switch self {
            case .select:
                return "Select"
            case .detail:
                return "Detail"
            case .main:
                return "Main"
            case .setting:
                return "Setting"
            case .name:
                return "Name"
            }
        }
    }
}
