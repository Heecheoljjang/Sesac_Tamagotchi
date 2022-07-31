//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, Identity {

    static var identity = String(describing: MainViewController.self)
    
    let userDefaults = UserDefaults.standard
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel! // 랜덤한 메세지 -> 구조체로 데이터 만들어서 다마고치 데이터형태에서 사용
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! // 이름
    @IBOutlet weak var nameView: UIView! // 이름 레이블 담은 뷰
    @IBOutlet weak var statusLabel: UILabel! // 레벨, 밥, 물방울 레이블
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var foodLineView: UIView!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var foodOuterView: UIView!
    @IBOutlet weak var waterOuterView: UIView!
    @IBOutlet weak var waterTextField: UITextField!
    @IBOutlet weak var waterLineView: UIView!
    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var navLineView: UIView!
    
    //레벨, 밥알, 물방울 -> UserDefaults로 관리해야할듯
    //연산 프로퍼티 활용
    var currentStatus: Status = Status()

    //메인화면에선 앱이 꺼졌다 켜질 수도 있으므로 UserDefaults로 데이터 받아와야함.
    var tamaData: Tamagotchi = Tamagotchi()
    
    var exp: Double?
    var messages: [String] = []
    var masterName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바 세팅
        setUpNavigationBar()
        
        // 디코딩해서 데이터가져오기
        if let savedTamagotchiData = userDefaults.object(forKey: UserDefaultsKey.tamagotchi.rawValue) as? Data, let savedStatusData = userDefaults.object(forKey: UserDefaultsKey.status.rawValue) as? Data {
            
            let decoder = JSONDecoder()
            if let tamagotchiData = try? decoder.decode(Tamagotchi.self, from: savedTamagotchiData), let statusData = try? decoder.decode(Status.self, from: savedStatusData)  {
                
                tamaData = tamagotchiData
                currentStatus = statusData
            }
        }
        
        // 가져온 데이터로 이미지, 이름, 상태 세팅

        currentStatus.typeNumber = "\(tamaData.number)"
        profileImageView.image = UIImage(named: currentStatus.profileImg)
        
        nameLabel.text = tamaData.name
        statusLabel.text = currentStatus.statusLabel
        
        //UI세팅
        setViewUI()
        
    }
    
    //MARK: - 네비게이션 바 세팅
    func setUpNavigationBar() {
        // 네비게이션 바 세팅
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ImageName.person.rawValue), style: .plain, target: self, action: #selector(tapSettingBtn))
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacBorder, .font: UIFont(name: CustomFont.bold.rawValue, size: 17)! ]
        
        // 네비게이션 타이틀 색
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacBorder]
        navLineView.backgroundColor = .sesacBorder // 네비게이션 바텀라인: UIView를 얇게 붙여서 구현
    }
    
    // pop됐을땐 viewDidLoad가 실행되지않으므로
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 키보드가 올라오고 내려오는 것을 감지해서 selector에 있는 메서드 실행
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if let name = userDefaults.string(forKey: UserDefaultsKey.name.rawValue) {
            masterName = name
            title = "\(name)님의 다마고치"
        }

        // 확실하게 값이 있으므로 강제추출
        messages = [
            "안녕하세요 \(masterName!)님!!!", "배고파요!! 밥이랑 물주세요", "\(masterName!)님! 공부는 잘 하고있으신가요?", "\(masterName!)님 블로그는 왜 안쓰세요?",
            "오늘은 어떤 공부를 하셨나요?", "내일은 어떤 공부를 하실 예정이에요?", "다른 다마고치들은 특식도 먹던데..나만 없어", "열심히 크고 있어요!",
            "테이블뷰와 컬렉션뷰의 차이는 무엇일까요?", "WWDC는 다 챙겨보셨나요?", "\(masterName!)님!! 저랑 놀아주세요.", "멘토님들에게 감사하다는 인사는 하셨나요?",
            "지금 당장 저에게 밥을 주시면 \(masterName!)님께 좋은 일만 생기게 기도해드릴게요!!", "\(masterName!)님 바보", "목말라요"
        ]
        
        //메세지 띄우기
        messageLabel.text = messages.randomElement()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 메인화면에서만 키보드를 감지할 것이기때문에 옵저버제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    func storyboardInit(_ StoryboardName: String) -> UIStoryboard {
        UIStoryboard(name: StoryboardName, bundle: nil)
    }
    // 키보드에 따라 뷰를 올리고 내리는 메서드
    @objc func keyboardWillShow(_ sender: Notification) {
        self.navigationController?.view.frame.origin.y = -190 // 뷰 전체를 올림
        
    }
    @objc func keyboardWillHide(_ sender: Notification) {
        self.navigationController?.view.frame.origin.y = 0 // 다시 원상복구
    }
    
   
    @objc func tapSettingBtn() {
        let sb = storyboardInit(StoryboardName.setting.rawValue)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identity) as? SettingTableViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 배경 탭하면 키보드 내리기
    @IBAction func keyboardDown(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }

    
    // 텍스트필드에서 리턴눌렀을때 버튼함수 실행
    @IBAction func tapFoodTextFieldReturn(_ sender: UITextField) {
        
        tapFoodBtn(foodButton)

    }
    @IBAction func tapWaterTextFieldReturn(_ sender: UITextField) {
        
        tapWaterBtn(waterButton)

    }

    
    //밥주기 버튼
    @IBAction func tapFoodBtn(_ sender: UIButton) {

        // stateLabel(밥알 개수) 텍스트필드 조건 확인
        if foodTextField.text == "" {
            currentStatus.food += 1
        } else {
            if let foodText = foodTextField.text {
                if Int(foodText) != nil {
                    if Int(foodText)! >= 100 || Int(foodText)! <= 0{
                        showAlert(title: "너무 많잖아요..")
                    } else {
                        currentStatus.food += Int(foodText)!
                    }
                } else {
                    showAlert(title: "숫자만 입력해야합니다.")
                }
            }
        }
        // 이미지 세팅. 레벨을 연산프로퍼티에 의해 자동으로 연산
        currentStatus.typeNumber = "\(tamaData.number)"
        profileImageView.image = UIImage(named: currentStatus.profileImg)
        
        // 메세지 레이블
        messageLabel.text = messages.randomElement()
        
        // 상태 레이블 새로고침 및 저장 -> 마찬가지로 아카이빙해서 저장
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Status(food: currentStatus.food, water: currentStatus.water)) {
            userDefaults.setValue(encoded, forKey: UserDefaultsKey.status.rawValue)
            
        }
 
        statusLabel.text = currentStatus.statusLabel
        
        // 텍스트필드 비워주기
        foodTextField.text = ""

        // 키보드내리기
        view.endEditing(true)
    }
    
    // 물주기 버튼
    @IBAction func tapWaterBtn(_ sender: UIButton) {
        
        // stateLabel(물방울 개수) 텍스트필드 조건 확인
        if waterTextField.text == "" {
            currentStatus.water += 1
        } else {
            if let waterText = waterTextField.text {
                if Int(waterText) != nil {
                    if Int(waterText)! >= 100 || Int(waterText)! <= 0{
                        showAlert(title: "너무 많잖아요..")
                    } else {
                        currentStatus.water += Int(waterText)!
                    }
                } else {
                    showAlert(title: "숫자만 입력해야합니다.")
                }
            }
        }
        // 이미지 세팅. 레벨을 연산프로퍼티에 의해 자동으로 연산
        currentStatus.typeNumber = "\(tamaData.number)"
        profileImageView.image = UIImage(named: currentStatus.profileImg)
        
        // 메세지 레이블
        messageLabel.text = messages.randomElement()
        
        // 상태 레이블 새로고침 및 저장 -> 마찬가지로 아카이빙해서 저장
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Status(food: currentStatus.food, water: currentStatus.water)) {
            userDefaults.setValue(encoded, forKey: UserDefaultsKey.status.rawValue)
            
        }
        
        statusLabel.text = currentStatus.statusLabel
        
        // 텍스트필드 비워주기
        waterTextField.text = ""

        // 키보드내리기
        view.endEditing(true)
    }
    
    //UI세팅
    func setViewUI() {
        
        view.backgroundColor = .sesacBackground
        messageLabel.font = UIFont(name: CustomFont.regular.rawValue, size: 14)
        messageLabel.textColor = .sesacBorder
        
        messageView.backgroundColor = .sesacBackground
        
        nameLabel.textColor = .sesacBorder
        nameLabel.font = UIFont(name: CustomFont.bold.rawValue, size: 13)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.backgroundColor = .labelBackgroundColor
        nameView.backgroundColor = .labelBackgroundColor
        nameView.layer.borderColor = UIColor.sesacBorder.cgColor
        nameView.layer.borderWidth = 0.5
        nameView.layer.cornerRadius = 5
        
        statusLabel.font = UIFont(name: CustomFont.bold.rawValue, size: 15)
        statusLabel.textColor = .sesacBorder
        
        foodOuterView.backgroundColor = .sesacBackground
        foodLineView.backgroundColor = .sesacBorder
        foodTextField.placeholder = "밥주세용"
        foodTextField.backgroundColor = .sesacBackground
        foodButton.backgroundColor = .sesacBackground
        foodButton.layer.cornerRadius = 5
        foodButton.layer.borderWidth = 0.5
        foodButton.layer.borderColor = UIColor.sesacBorder.cgColor
        foodButton.setImage(UIImage(systemName: ImageName.drop.rawValue), for: .normal)
        foodButton.setTitle(" 밥먹기", for: .normal)
        foodButton.titleLabel?.font = UIFont(name: CustomFont.bold.rawValue, size: 13)
        foodButton.setTitleColor(.sesacBorder, for: .normal)
        
        waterOuterView.backgroundColor = .sesacBackground
        waterLineView.backgroundColor = .sesacBorder
        waterTextField.placeholder = "물주세용"
        waterTextField.backgroundColor = .sesacBackground
        waterButton.backgroundColor = .sesacBackground
        waterButton.layer.cornerRadius = 5
        waterButton.layer.borderWidth = 0.5
        waterButton.layer.borderColor = UIColor.sesacBorder.cgColor
        waterButton.setImage(UIImage(systemName: ImageName.leaf.rawValue), for: .normal)
        waterButton.setTitle(" 물먹기", for: .normal)
        waterButton.titleLabel?.font = UIFont(name: CustomFont.bold.rawValue, size: 13)
        waterButton.setTitleColor(.sesacBorder, for: .normal)
        
    }
}
