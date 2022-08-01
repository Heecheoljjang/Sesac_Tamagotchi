//
//  UIViewController+Extension.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/23.
//

import UIKit

extension UIViewController: IdentifierProtocol {
    
    // alert함수
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel , handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    //identifier
    static var reuseIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
