//
//  NameViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/23.
//

import UIKit

class NameViewController: UIViewController {

    static let identity = "NameViewController"
    
    @IBOutlet weak var namingTextField: UITextField!
    
    var currentName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(tapSaveBtn))
        
        namingTextField.text = currentName
        namingTextField.placeholder = "이름을 입력해주세요!!"
        
    }
    
    // 이전화면으로 pop하고 userDefaults 바꿈
    @objc func tapSaveBtn() {
        
        if namingTextField.text == "" {
            // 아무것도 입력안하고 저장누르면 입력하라고 alert띄우기
            showAlert(title: "이름을 입력하시고 저장해주세요!!")
        } else {
            if let newName = namingTextField.text {
                
                UserDefaults.standard.set(newName, forKey: "name")
                navigationController?.popViewController(animated: true)
                
            }
        }
        
    }

}
