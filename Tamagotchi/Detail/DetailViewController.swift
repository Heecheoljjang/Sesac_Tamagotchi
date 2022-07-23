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
        
        selectBtn.setTitle("시작하기", for: .normal)
        selectBtn.layer.maskedCorners = [.layerMinXMaxYCorner]
        selectBtn.layer.cornerRadius = 10
        
        secondLineView.backgroundColor = .systemGray4
        
        profileImg.image = data.profileImg
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
               
        // 첫 화면이라면 name으로 대장을, 변경하기 화면이라면 UserDefaults에 들어있는 값으로
        if UserDefaults.standard.string(forKey: "name") == nil {
            vc.name = "대장님"
            UserDefaults.standard.set("대장님", forKey: "name")
        } else {
            if let name = UserDefaults.standard.string(forKey: "name") {
                vc.name = name
            }
        }
        
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
}
