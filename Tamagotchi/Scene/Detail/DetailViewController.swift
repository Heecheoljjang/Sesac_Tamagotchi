//
//  DetailViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class DetailViewController: UIViewController, Identity {

    static var identity = String(describing: DetailViewController.self)
    
    let userDefaults = UserDefaults.standard
    
//    var tamagotchiData: Tamagotchi?
    var tamagotchiData = Tamagotchi()
    
    let initialData = Status(food: 0, water: 0)

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var secondLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        if let tamagotchiData = tamagotchiData {
//            settingView(data: tamagotchiData)
//        }
        settingView(data: tamagotchiData)
        
        if userDefaults.string(forKey: UserDefaultsKey.name.rawValue) == nil {
            selectButton.setTitle("시작하기", for: .normal)
        } else {
            selectButton.setTitle("변경하기", for: .normal)
        }

    }
    
    func settingView(data: Tamagotchi) {
        
        view.backgroundColor = .black.withAlphaComponent(0.4)
        backgroundView.backgroundColor = .sesacBackground
        backgroundView.layer.cornerRadius = 10
        
        labelView.layer.cornerRadius = 5
        labelView.layer.borderWidth = 0.5
        labelView.layer.borderColor = UIColor.sesacBorder.cgColor
        labelView.backgroundColor = .labelBackgroundColor
        
        nameLabel.backgroundColor = .labelBackgroundColor
        nameLabel.font = UIFont(name: CustomFont.bold.rawValue, size: 13)
        nameLabel.textColor = .sesacBorder
        
        lineView.backgroundColor = .sesacBorder
        
        detailLabel.text = data.detail
        detailLabel.font = UIFont(name: CustomFont.regular.rawValue, size: 14)
        detailLabel.textColor = .sesacBorder
        detailLabel.adjustsFontSizeToFitWidth = true
        
        cancleButton.setTitle("취소", for: .normal)
        cancleButton.titleLabel?.font = UIFont(name: CustomFont.regular.rawValue, size: 15)
        cancleButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        cancleButton.layer.cornerRadius = 10
        cancleButton.backgroundColor = .cancelColor
        
        selectButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        selectButton.layer.cornerRadius = 10
        selectButton.titleLabel?.font = UIFont(name: CustomFont.regular.rawValue, size: 15)

        secondLineView.backgroundColor = .systemGray4
        
        profileImageView.image = UIImage(named: data.profileImg)
        nameLabel.text = data.name
        detailLabel.text = data.detail
    }
    
    @IBAction func tapCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tapSelect(_ sender: UIButton) {
        
        // 메인화면으로 루트뷰컨틀롤러 이동
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene // 앱을 다시 처음부터 실행해주는 코드
        let sceneDelegate = windowScene?.delegate as? SceneDelegate // 신딜리게이트 클래스에 접근
                
        let sb = storyboardInit(StoryboardName.main.rawValue)
        guard let vc = sb.instantiateViewController(withIdentifier: MainViewController.identity) as? MainViewController else { return }
               
        //UserDefaults에 선택한 다마고치 저장. 
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tamagotchiData) {
            userDefaults.setValue(encoded, forKey: UserDefaultsKey.tamagotchi.rawValue)
        }

        // 첫 화면이라면 name으로 대장, 초기 레벨, 밥, 물값 저장
        if userDefaults.string(forKey: UserDefaultsKey.name.rawValue) == nil {
            userDefaults.set("대장", forKey: UserDefaultsKey.name.rawValue)
            
            // 초기 상태값 저장 (1, 0, 0)
            if let encoded = try? encoder.encode(initialData) {
                userDefaults.setValue(encoded, forKey: UserDefaultsKey.status.rawValue)
            }
        }
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
    func storyboardInit(_ StoryboardName: String) -> UIStoryboard {
        UIStoryboard(name: StoryboardName, bundle: nil)
    }
    
}
