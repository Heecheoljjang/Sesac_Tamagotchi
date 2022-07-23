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
        
        // UserDefault에 값이 있으면 변경하기 화면이므로 값 변화x
        // 값이 없다면 초기화면이므로 다시 대장으로
    }
    
}
