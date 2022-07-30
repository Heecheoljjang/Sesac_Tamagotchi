//
//  bbCollectionViewCell.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/24.
//

import UIKit

class SelectCollectionViewCell: UICollectionViewCell, Identity {
    
    static var identity = String(describing: SelectCollectionViewCell.self)
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCell()
    }
    
    func setCell() {
        labelView.layer.borderWidth = 0.5
        labelView.layer.borderColor = UIColor.sesacBorder.cgColor
        labelView.layer.cornerRadius = 5
        labelView.backgroundColor = .labelBackgroundColor
        //nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)\
        nameLabel.font = UIFont(name: "MICEGothic OTF Bold", size: 13)
        nameLabel.backgroundColor = .labelBackgroundColor
        nameLabel.textColor = .sesacBorder
        nameLabel.adjustsFontSizeToFitWidth = true
        
        self.backgroundColor = .sesacBackground
    }
}
