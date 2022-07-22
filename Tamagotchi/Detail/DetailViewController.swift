//
//  DetailViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class DetailViewController: UIViewController {

    static let identity = "DetailViewController"
    
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

        view.backgroundColor = .black.withAlphaComponent(0.4)
        backgroundView.backgroundColor = .sesacBackground
        backgroundView.layer.cornerRadius = 10
        labelView.layer.cornerRadius = 5
        labelView.layer.borderWidth = 1
        labelView.layer.borderColor = UIColor.sesacBorder.cgColor
        nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        lineView.backgroundColor = .sesacBorder
        detailLabel.text = "저는 따끔따끔 다마고치입니다. 키는 2cm이고 몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!"
        detailLabel.font = .systemFont(ofSize: 14, weight: .regular)
        detailLabel.adjustsFontSizeToFitWidth = true
        cancleBtn.setTitle("취소", for: .normal)
        cancleBtn.backgroundColor = .sesacBorder
        cancleBtn.layer.maskedCorners = [.layerMinXMaxYCorner]
        cancleBtn.layer.cornerRadius = 5
        selectBtn.setTitle("시작하기", for: .normal)
        selectBtn.layer.maskedCorners = [.layerMinXMaxYCorner]
        selectBtn.layer.cornerRadius = 5
        secondLineView.backgroundColor = .systemGray5
    
    }
    
    
}
