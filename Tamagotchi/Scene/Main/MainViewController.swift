//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, Identity {

    static var identity = String(describing: MainViewController.self)
    
//    let userDefaults = UserDefaults.standard
    
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
    var currentStatus = Status()

    //메인화면에선 앱이 꺼졌다 켜질 수도 있으므로 UserDefaults로 데이터 받아와야함.
    var tamaData = Tamagotchi()
    
    var exp: Double?
    var messages: [String] = []
    var masterName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 바 세팅
        setUpNavigationBar()
        
        // 디코딩해서 데이터가져오기
//        if let savedTamagotchiData = userDefaults.object(forKey: UserDefaultsKey.tamagotchi.rawValue) as? Data, let savedStatusData = userDefaults.object(forKey: UserDefaultsKey.status.rawValue) as? Data {
//
//            let decoder = JSONDecoder()
//            if let tamagotchiData = try? decoder.decode(Tamagotchi.self, from: savedTamagotchiData), let statusData = try? decoder.decode(Status.self, from: savedStatusData)  {
//
//                tamaData = tamagotchiData
//                currentStatus = statusData
//            }
//        }
        let decoder = JSONDecoder()
        if let tamagotchiData = try? decoder.decode(Tamagotchi.self, from: UserDefaultsHelper.shared.tamagotchi), let statusData = try? decoder.decode(Status.self, from: UserDefaultsHelper.shared.status) {
            
            tamaData = tamagotchiData
            currentStatus = statusData

        }
        
        // 가져온 데이터로 이미지, 이름, 상태 세팅

        currentStatus.typeNumber = "\(tamaData.number)"
        profileImageView.image = UIImage(named: currentStatus.profileImg)
        
        nameLabel.text = tamaData.name
        statusLabel.text = currentStatus.statusLabel
        
        //UI세팅
        setViewUI()
        
        //버튼 태그 설정
        foodButton.tag = 1
        waterButton.tag = 0
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        if let name = userDefaults.string(forKey: UserDefaultsKey.name.rawValue) {
//            masterName = name
//            title = "\(name)님의 다마고치"
//        }

        masterName = UserDefaultsHelper.shared.name


        title = "\(masterName!)님의 다마고치"

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
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    func storyboardInit(_ StoryboardName: String) -> UIStoryboard {
        UIStoryboard(name: StoryboardName, bundle: nil)
    }
    // 키보드에 따라 뷰를 올리고 내리는 메서드
    @objc func keyboardWillChange(_ sender: Notification) {
        
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        let waterBottomSpace = view.frame.height - waterOuterView.frame.origin.y
       
        if self.navigationController?.view.frame.origin.y == 0 {
            self.navigationController?.view.frame.origin.y = -(keyboardHeight - waterBottomSpace + 80)
        }
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
        
        tapButton(foodButton)

    }
    @IBAction func tapWaterTextFieldReturn(_ sender: UITextField) {
        
        tapButton(waterButton)

    }
    
    @IBAction func tapButton(_ sender: UIButton) {

        if sender.tag == 0 {
            buttonMethod(textField: waterTextField, button: sender)
        } else {
            buttonMethod(textField: foodTextField, button: sender)
        }
    }

    // 버튼 메서드
    func buttonMethod(textField: UITextField, button: UIButton) {
        if textField.text == "" {
            if button.tag == 0 {
                currentStatus.water += 1
            } else if button.tag == 1 {
                currentStatus.food += 1
            }
        } else {
            if let text = textField.text {
                if Int(text) != nil {
                    if Int(text)! >= 100 || Int(text)! <= 0 {
                        showAlert(title: "너무 많잖아요..")
                    } else {
                        if button.tag == 0 {
                            currentStatus.water += Int(text)!
                        } else if button.tag == 1 {
                            currentStatus.food += Int(text)!
                        }
                    }
                } else {
                    showAlert(title: "입력이 너무 길거나 문자가 포함되어 있습니다.")
                }
            }
        }
        currentStatus.typeNumber = "\(tamaData.number)"
        profileImageView.image = UIImage(named: currentStatus.profileImg)
        
        messageLabel.text = messages.randomElement()
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Status(food: currentStatus.food, water: currentStatus.water)) {
//            userDefaults.setValue(encoded, forKey: UserDefaultsKey.status.rawValue)
            UserDefaultsHelper.shared.status = encoded
        }
        
        statusLabel.text = currentStatus.statusLabel
        
        // 텍스트필드 비워주기
        textField.text = ""

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
        
        setUpButtonUI(button: foodButton, outerView: foodOuterView, lineView: foodLineView, textField: foodTextField, placeholder: "밥주세용", buttonTitle: " 밥먹기", buttonImage: ImageName.drop.rawValue)
        setUpButtonUI(button: waterButton, outerView: waterOuterView, lineView: waterLineView, textField: waterTextField, placeholder: "물주세용", buttonTitle: " 물먹기", buttonImage: ImageName.leaf.rawValue)
        
    }
    
    func setUpButtonUI(button: UIButton, outerView: UIView, lineView: UIView, textField: UITextField, placeholder: String, buttonTitle: String, buttonImage: String) {
        outerView.backgroundColor = .sesacBackground
        lineView.backgroundColor = .sesacBorder
        textField.placeholder = placeholder
        textField.backgroundColor = .sesacBackground
        button.backgroundColor = .sesacBackground
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.sesacBorder.cgColor
        button.setImage(UIImage(systemName: buttonImage), for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.bold.rawValue, size: 13)
        button.setTitleColor(.sesacBorder, for: .normal)
    }
}
