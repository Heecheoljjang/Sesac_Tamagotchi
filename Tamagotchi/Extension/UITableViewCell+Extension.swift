//
//  UITableViewCell+Extension.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/08/02.
//

import Foundation
import UIKit

extension UITableViewCell: IdentifierProtocol {
    static var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
