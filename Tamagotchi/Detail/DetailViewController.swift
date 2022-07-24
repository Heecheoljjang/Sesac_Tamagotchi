//
//  DetailViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class DetailViewController: UIViewController {

    static let identity = "DetailViewController"
    
    var tamagotchiData: Tamagotchi?
    let initialData: Status = Status(level: 1, food: 0, water: 0)

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var secondLineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let tamagotchiData = tamagotchiData {
            settingView(data: tamagotchiData)
        }
        
        if UserDefaults.standard.string(forKey: "name") == nil {
            selectBtn.setTitle("시작하기", for: .normal)
        } else {
            selectBtn.setTitle("변경하기", for: .normal)
        }

    }
    
    func settingView(data: Tamagotchi) {
        
        view.backgroundColor = .black.withAlphaComponent(0.4)
        backgroundView.backgroundColor = .sesacBackground
        backgroundView.layer.cornerRadius = 10
        
        labelView.layer.cornerRadius = 5
        labelView.layer.borderWidth = 0.5
        labelView.layer.borderColor = UIColor.sesacBorder.cgColor
        labelView.backgroundColor = .sesacBackground
        
        nameLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        nameLabel.textColor = .sesacBorder
        
        lineView.backgroundColor = .sesacBorder
        
        detailLabel.text = data.detail
        detailLabel.font = .systemFont(ofSize: 14, weight: .regular)
        detailLabel.textColor = .sesacBorder
        detailLabel.adjustsFontSizeToFitWidth = true
        
        cancleBtn.setTitle("취소", for: .normal)
        cancleBtn.layer.maskedCorners = [.layerMinXMaxYCorner]
        cancleBtn.layer.cornerRadius = 10
        cancleBtn.backgroundColor = .cancelColor
        
        selectBtn.layer.maskedCorners = [.layerMinXMaxYCorner]
        selectBtn.layer.cornerRadius = 10
        
        secondLineView.backgroundColor = .systemGray4
        
        profileImg.image = UIImage(named: data.profileImg)
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
                
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: MainViewController.identity) as? MainViewController else { return }
               
        //UserDefaults에 선택한 다마고치 저장. 
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tamagotchiData) {
            UserDefaults.standard.setValue(encoded, forKey: "tamagotchi")
            print(encoded)
        }

        // 첫 화면이라면 name으로 대장, 초기 레벨, 밥, 물값 저장
        if UserDefaults.standard.string(forKey: "name") == nil {
            UserDefaults.standard.set("대장", forKey: "name")
            
            // 초기 상태값 저장 (1, 0, 0)
            if let encoded = try? encoder.encode(initialData) {
                UserDefaults.standard.setValue(encoded, forKey: "status")
            }
        }
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
}
