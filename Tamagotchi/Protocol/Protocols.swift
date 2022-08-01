//
//  Protocols.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/30.
//

import Foundation
import UIKit

protocol IdentifierProtocol {
    
    static var reuseIdentifier: String { get }
}

@objc protocol SetUpMethod {
    
    @objc optional func setUpCollectionView()
    @objc optional func setUpNavigationBar()
    @objc optional func setUpView()
    
    //MainViewController에서만 쓰이는 메서드인데 버튼 setup하는 메서드가 하나여서 매개변수와 같이 가져옴
    @objc optional func setUpButton(button: UIButton, outerView: UIView, lineView: UIView, textField: UITextField, placeholder: String, buttonTitle: String, buttonImage: String)
    
}
