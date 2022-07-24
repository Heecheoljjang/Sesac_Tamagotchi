//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    static let identity = "MainViewController"
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel! // 랜덤한 메세지 -> 구조체로 데이터 만들어서 다마고치 데이터형태에서 사용
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! // 이름
    @IBOutlet weak var nameView: UIView! // 이름 레이블 담은 뷰
    @IBOutlet weak var statusLabel: UILabel! // 레벨, 밥, 물방울 레이블
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var foodLineView: UIView!
    @IBOutlet weak var foodBtn: UIButton!
    @IBOutlet weak var foodOuterView: UIView!
    @IBOutlet weak var waterOuterView: UIView!
    @IBOutlet weak var waterTextField: UITextField!
    @IBOutlet weak var waterLineView: UIView!
    @IBOutlet weak var waterBtn: UIButton!
    @IBOutlet weak var navLineView: UIView!
    
    @IBOutlet weak var betweenFoodWater: NSLayoutConstraint!
    
    //레벨, 밥알, 물방울 -> UserDefaults로 관리해야할듯
    var currentStatus: Status?
    //메인화면에선 앱이 꺼졌다 켜질 수도 있으므로 UserDefaults로 데이터 받아와야함.
    var tamaData: Tamagotchi?
    var level: Int = 1
    var food: Int = 0
    var water: Int = 0
    var exp: Double?
    var messages: [String] = []
    var masterName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // 키보드가 뷰 가리는 현상 해결
        foodTextField.delegate = self
        waterTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(tapSettingBtn))
        navigationItem.backButtonTitle = ""
        
        
        // 네비게이션 타이틀 색
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacBorder]
        navLineView.backgroundColor = .sesacBorder // 네비게이션 바텀라인: UIView를 얇게 붙여서 구현
        
        // 디코딩해서 데이터가져오기
        if let savedTamagotchiData = userDefaults.object(forKey: "tamagotchi") as? Data, let savedStatusData = userDefaults.object(forKey: "status") as? Data {
            
            let decoder = JSONDecoder()
            if let tamagotchiData = try? decoder.decode(Tamagotchi.self, from: savedTamagotchiData), let statusData = try? decoder.decode(Status.self, from: savedStatusData)  {
                tamaData = tamagotchiData
                currentStatus = statusData
            }
        }
        
        // 가져온 데이터로 이미지, 이름, 상태 세팅
        if let tamaData = tamaData, let statusData = currentStatus {
            
            level = statusData.level
            food = statusData.food
            water = statusData.water
            
            if level < 10 && level > 0 {
                profileImg.image = UIImage(named: "\(tamaData.number)-\(level)")
            } else if level >= 10{
                profileImg.image = UIImage(named: "\(tamaData.number)-9")
            } else {
                profileImg.image = UIImage(named: "noImage")
            }
            
            nameLabel.text = tamaData.name
            statusLabel.text = "LV\(statusData.level) · 밥알 \(statusData.food)개 · 물방울 \(statusData.water)개"
        }
        
        //UI세팅
        setViewUI()
        
    }

    
    // pop됐을땐 viewDidLoad가 실행되지않으므로
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let name = userDefaults.string(forKey: "name") {
            masterName = name
        }
        
        if let currentName = userDefaults.string(forKey: "name") {
            title = "\(currentName)님의 다마고치"
        }
        // 확실하게 값이 있으므로 강제추출
        messages = [
            "안녕하세요 \(masterName!)님!!!", "배고파요!! 밥이랑 물주세요", "\(masterName!)님! 공부는 잘 하고있으신가요?", "\(masterName!)님 블로그는 왜 안쓰세요?",
            "오늘은 어떤 공부를 하셨나요?", "내일은 어떤 공부를 하실 예정이에요?", "다른 다마고치들은 특식도 먹던데..나만 없어", "열심히 크고 있어요!",
            "테이블뷰와 컬렉션뷰의 차이는 무엇일까요?", "WWDC는 다 챙겨보셨나요?", "\(masterName!)님!! 저랑 놀아주세요.", "멘토님들에게 감사하다는 인사는 하셨나요?",
            "지금 당장 저에게 밥을 주시면 \(masterName!)님께 좋은 일만 생기게 기도해드릴게요!!", "\(masterName!)님 바보"
        ]
        //메세지 띄우기
        messageLabel.text = messages.randomElement()
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        print("hh")
        self.view.frame.origin.y = -170
        navigationController?.navigationBar.isHidden = true

    }
    @objc func keyboardWillHide(_ sender: Notification) {
        print("hh")

        self.view.frame.origin.y = 0
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func keyboardDown(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }

    @objc func tapSettingBtn() {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identity) as? SettingTableViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 텍스트필드에서 리턴눌렀을때 버튼함수 실행
    @IBAction func tapFoodTextFieldReturn(_ sender: UITextField) {
        
        tapFoodBtn(foodBtn)

    }
    
    @IBAction func tapWaterTextFieldReturn(_ sender: UITextField) {
        
        tapWaterBtn(waterBtn)

    }

    
    //밥주기 버튼
    @IBAction func tapFoodBtn(_ sender: UIButton) {
        // stateLabel(밥알 개수) 텍스트필드 조건 확인
        if foodTextField.text == "" {
            food += 1
        } else {
            if let foodText = foodTextField.text {
                if Int(foodText) != nil {
                    if Int(foodText)! >= 100 || Int(foodText)! <= 0{
                        showAlert(title: "장난하지말고 다시.")
                    } else {
                        food += Int(foodText)!
                    }
                } else {
                    showAlert(title: "숫자만 입력해야합니다.")
                }
            }
        }
        // 경험치 계산해서 이미지랑 레벨 세팅
        exp = (Double(food) / 5) + (Double(water) / 2)

        if let exp = exp, let tamaData = tamaData {
            if exp < 20 && exp >= 0 {
                level = 1
                profileImg.image = UIImage(named: "\(tamaData.number)-\(level)")
            } else if exp >= 20 && exp < 100 {
                level = Int(exp / 10)
                profileImg.image = UIImage(named: "\(tamaData.number)-\(level)")
            } else if exp >= 100 {
                level = 10
                profileImg.image = UIImage(named: "\(tamaData.number)-9")
            } else {
                showAlert(title: "레벨 오류입니다.")
            }
        }
        
        // 메세지 레이블
        messageLabel.text = messages.randomElement()
        
        // 상태 레이블 새로고침 및 저장 -> 마찬가지로 아카이빙해서 저장
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Status(level: level, food: food, water: water)) {
            userDefaults.setValue(encoded, forKey: "status")
        }
        
        statusLabel.text = "LV\(level) · 밥알 \(food)개 · 물방울 \(water)개"
        
        // 텍스트필드 비워주기
        foodTextField.text = ""
    }
    
    // 물주기 버튼
    @IBAction func tapWaterBtn(_ sender: UIButton) {
        // stateLabel(물방울 개수) 텍스트필드 조건 확인
        if waterTextField.text == "" {
            water += 1
        } else {
            if let waterText = waterTextField.text {
                if Int(waterText) != nil {
                    if Int(waterText)! >= 50 || Int(waterText)! <= 0{
                        showAlert(title: "장난하지말고 다시.")
                    } else {
                        water += Int(waterText)!
                    }
                } else {
                    showAlert(title: "숫자만 입력해야합니다.")
                }
            }
        }
        // 경험치 계산해서 이미지랑 레벨 세팅
        exp = (Double(food) / 5) + (Double(water) / 2)
        
        if let exp = exp, let tamaData = tamaData {
            if exp < 20 && exp >= 0 {
                level = 1
                profileImg.image = UIImage(named: "\(tamaData.number)-\(level)")
            } else if exp >= 20 && exp < 100 {
                level = Int(exp / 10)
                profileImg.image = UIImage(named: "\(tamaData.number)-\(level)")
            } else if exp >= 100 {
                level = 10
                profileImg.image = UIImage(named: "\(tamaData.number)-9")
            } else {
                showAlert(title: "레벨 오류입니다.")
            }
        }
        
        // 메세지 레이블
        messageLabel.text = messages.randomElement()
        
        // 상태 레이블 새로고침 및 저장 -> 마찬가지로 아카이빙해서 저장
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Status(level: level, food: food, water: water)) {
            userDefaults.setValue(encoded, forKey: "status")
        }
        
        statusLabel.text = "LV\(level) · 밥알 \(food)개 · 물방울 \(water)개"
        
        // 텍스트필드 비워주기
        waterTextField.text = ""
    }
    
    //UI세팅
    func setViewUI() {
        
        view.backgroundColor = .sesacBackground
        messageLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        messageLabel.textColor = .sesacBorder
        
        messageView.backgroundColor = .sesacBackground
        
        nameLabel.textColor = .sesacBorder
        nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.backgroundColor = .labelBackgroundColor
        nameView.backgroundColor = .labelBackgroundColor
        nameView.layer.borderColor = UIColor.sesacBorder.cgColor
        nameView.layer.borderWidth = 0.5
        nameView.layer.cornerRadius = 5
        
        statusLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        statusLabel.textColor = .sesacBorder
        
        foodOuterView.backgroundColor = .sesacBackground
        foodLineView.backgroundColor = .sesacBorder
        foodTextField.placeholder = "밥주세용"
        foodTextField.backgroundColor = .sesacBackground
//        foodTextField.keyboardType = .numberPad
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
//        waterTextField.keyboardType = .numberPad
        waterBtn.backgroundColor = .sesacBackground
        waterBtn.layer.cornerRadius = 5
        waterBtn.layer.borderWidth = 0.5
        waterBtn.layer.borderColor = UIColor.sesacBorder.cgColor
        waterBtn.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        waterBtn.setTitle(" 물먹기", for: .normal)
        waterBtn.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        waterBtn.setTitleColor(.sesacBorder, for: .normal)
        
    }
}
