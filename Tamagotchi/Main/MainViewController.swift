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
    var tamagotchiData: Tamagotchi?
    
    @IBOutlet weak var messageView: UIView!
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
        
        // 디코딩해서 데이터가져오기
        if let savedData = UserDefaults.standard.object(forKey: "tamagotchi") as? Data {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(Tamagotchi.self, from: savedData) {
                tamagotchiData = data
            }
        }
        
        // 가져온 데이터로 이미지랑 이름 세팅
        if let data = tamagotchiData {
            print(data.profileImg)
            profileImg.image = UIImage(named: data.profileImg)
            nameLabel.text = data.name
        }
        
        //UI세팅
        setViewUI()
        
    }
    
    // pop됐을땐 viewDidLoad가 실행되지않으므로
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentName = UserDefaults.standard.string(forKey: "name") {
            title = "\(currentName)님의 다마고치"
        }
    }
    
    func setViewUI() {
        
        view.backgroundColor = .sesacBackground
        messageLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        messageLabel.textColor = .sesacBorder
        
        messageView.backgroundColor = .sesacBackground
        
        nameLabel.textColor = .sesacBorder
        nameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameView.backgroundColor = .sesacBackground
        nameView.layer.borderColor = UIColor.sesacBorder.cgColor
        nameView.layer.borderWidth = 0.5
        nameView.layer.cornerRadius = 5
        
        stateLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        stateLabel.textColor = .sesacBorder
        
        foodOuterView.backgroundColor = .sesacBackground
        foodLineView.backgroundColor = .sesacBorder
        foodTextField.placeholder = "밥주세용"
        foodTextField.backgroundColor = .sesacBackground
        foodBtn.backgroundColor = .sesacBackground
        foodBtn.layer.cornerRadius = 5
        foodBtn.layer.borderWidth = 0.5
        foodBtn.layer.borderColor = UIColor.sesacBorder.cgColor
        foodBtn.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        foodBtn.setTitle(" 밥먹기", for: .normal)
        foodBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        foodBtn.setTitleColor(.sesacBorder, for: .normal)
        
        waterOuterView.backgroundColor = .sesacBackground
        waterLineView.backgroundColor = .sesacBorder
        waterTextField.placeholder = "물주세용"
        waterTextField.backgroundColor = .sesacBackground
        waterBtn.backgroundColor = .sesacBackground
        waterBtn.layer.cornerRadius = 5
        waterBtn.layer.borderWidth = 0.5
        waterBtn.layer.borderColor = UIColor.sesacBorder.cgColor
        waterBtn.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        waterBtn.setTitle(" 밥먹기", for: .normal)
        waterBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        waterBtn.setTitleColor(.sesacBorder, for: .normal)
        
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
