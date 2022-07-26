//
//  DetailViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class DetailViewController: UIViewController, SetUpMethod {

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

        //SetUpMethod Protocol
        setUpView()
        
        if UserDefaultsHelper.shared.name == "" {
            selectButton.setTitle(DetailViewButtonTitle.start, for: .normal)
        } else {
            selectButton.setTitle(DetailViewButtonTitle.change, for: .normal)
        }
        
        //데이터를 이용해서 세팅하는부분
        detailLabel.text = tamagotchiData.detail
        profileImageView.image = UIImage(named: tamagotchiData.profileImg)
        nameLabel.text = tamagotchiData.name
        detailLabel.text = tamagotchiData.detail
    }
    
    func setUpView() {
        
        view.backgroundColor = .black.withAlphaComponent(0.4)
        backgroundView.backgroundColor = .sesacBackground
        backgroundView.layer.cornerRadius = 10
        
        labelView.layer.cornerRadius = 5
        labelView.layer.borderWidth = 0.5
        labelView.layer.borderColor = UIColor.sesacBorder.cgColor
        labelView.backgroundColor = .labelBackgroundColor
        
        nameLabel.backgroundColor = .labelBackgroundColor
        nameLabel.font = UIFont(name: CustomFont.bold, size: 13)
        nameLabel.textColor = .sesacBorder
        
        lineView.backgroundColor = .sesacBorder
        
        detailLabel.font = UIFont(name: CustomFont.regular, size: 14)
        detailLabel.textColor = .sesacBorder
        detailLabel.adjustsFontSizeToFitWidth = true
        
        cancleButton.setTitle("취소", for: .normal)
        cancleButton.titleLabel?.font = UIFont(name: CustomFont.regular, size: 15)
        cancleButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        cancleButton.layer.cornerRadius = 10
        cancleButton.backgroundColor = .cancelColor
        
        selectButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        selectButton.layer.cornerRadius = 10
        selectButton.titleLabel?.font = UIFont(name: CustomFont.regular, size: 15)

        secondLineView.backgroundColor = .systemGray4
        
       
    }
    
    @IBAction func tapCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tapSelect(_ sender: UIButton) {
        
        // 메인화면으로 루트뷰컨틀롤러 이동
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene // 앱을 다시 처음부터 실행해주는 코드
        let sceneDelegate = windowScene?.delegate as? SceneDelegate // 신딜리게이트 클래스에 접근
                
        let sb = storyboardInit(StoryboardName.main)
        guard let vc = sb.instantiateViewController(withIdentifier: MainViewController.reuseIdentifier) as? MainViewController else { return }
               
        //UserDefaults에 선택한 다마고치 저장. 
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tamagotchiData) {
            //setValue
            UserDefaultsHelper.shared.tamagotchi = encoded
        }

        // 첫 화면이라면 name으로 대장, 초기 레벨, 밥, 물값 저장
        if UserDefaultsHelper.shared.name == "" {
            UserDefaultsHelper.shared.name = "대장"
            
            // 초기 상태값 저장 (1, 0, 0)
            if let encoded = try? encoder.encode(initialData) {
                UserDefaultsHelper.shared.status = encoded
            }
        }
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
    func storyboardInit(_ StoryboardName: String) -> UIStoryboard {
        UIStoryboard(name: StoryboardName, bundle: nil)
    }
    
}
