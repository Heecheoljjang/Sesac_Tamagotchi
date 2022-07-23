//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class MainViewController: UIViewController {

    static let identity = "MainViewController"
    
    //메인화면에선 앱이 꺼졌다 켜질 수도 있으므로 UserDefaults로 데이터 받아와야함.
    
    @IBOutlet weak var messageLabel: UILabel! // 랜덤한 메세지 -> 구조체로 데이터 만들어서 다마고치 데이터형태에서 사용
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! // 이름
    @IBOutlet weak var nameView: UIView! // 이름 레이블 담은 뷰
    @IBOutlet weak var stateLabel: UILabel! // 레벨, 밥, 물방울 레이블
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var foodLineView: UIView!
    @IBOutlet weak var foodBtn: UIButton!
    @IBOutlet weak var foodOuterView: UIView!
    @IBOutlet weak var waterOuterView: UIView!
    @IBOutlet weak var waterTextField: UITextField!
    @IBOutlet weak var waterLineView: UIView!
    @IBOutlet weak var waterBtn: UIButton!
    
    //레벨, 밥알, 물방울 -> UserDefaults로 관리해야할듯
    var myTamagotchi: [String: Int] = ["level": 1, "food": 0, "water": 0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(tapSettingBtn))
        navigationItem.backButtonTitle = ""
        
        
        
    }
    
    // pop됐을땐 viewDidLoad가 실행되지않으므로
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentName = UserDefaults.standard.string(forKey: "name") {
            title = "\(currentName)님의 다마고치"
        }
    }
    
    @objc func tapSettingBtn() {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identity) as? SettingTableViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapFoodBtn(_ sender: UIButton) {
        // stateLabel(밥알 개수), messageLabel 새로고침
        // 경험치 계산
    }
    
    @IBAction func tapWaterBtn(_ sender: UIButton) {
    }
    
}
