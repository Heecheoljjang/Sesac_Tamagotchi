//
//  NameViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/23.
//

import UIKit

class NameViewController: UIViewController {

    static let identity = "NameViewController"
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var namingTextField: UITextField!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var navBottomLine: UIView!
    
    var currentName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(tapSaveBtn))
        
        // 여기 타이틀은 고정같음
//        if let titleName = userDefaults.string(forKey: "name") {
//            title = "\(titleName)님 이름 정하기"
//        }
        title = "대장님 이름 정하기"
        
        view.backgroundColor = .sesacBackground
        navBottomLine.backgroundColor = .sesacBorder
        namingTextField.text = currentName
        namingTextField.placeholder = "이름을 입력해주세요!!"
        namingTextField.textColor = .sesacBorder
        namingTextField.font = .systemFont(ofSize: 14, weight: .semibold)
        namingTextField.backgroundColor = .sesacBackground
        
        bottomLine.backgroundColor = .sesacBorder
        
    }
    
    // 이전화면으로 pop하고 userDefaults 바꿈
    @objc func tapSaveBtn() {
        
        if namingTextField.text == "" {
            // 아무것도 입력안하고 저장누르면 입력하라고 alert띄우기
            showAlert(title: "이름을 입력하시고 저장해주세요!!")
        } else {
            if let newName = namingTextField.text {
                
                if newName.count >= 2 && newName.count <= 6 {
                    userDefaults.set(newName, forKey: "name")
                    navigationController?.popViewController(animated: true)
                } else {
                    showAlert(title: "2글자 이상 6글자 이하의 이름만 가능해요!")
                }
            }
        }
        
    }
    @IBAction func nameTextFieldReturn(_ sender: UITextField) {
        
        tapSaveBtn()
    }
    
    // 배경 탭했을때 키보드 내리기
    @IBAction func keyboardDown(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
}
