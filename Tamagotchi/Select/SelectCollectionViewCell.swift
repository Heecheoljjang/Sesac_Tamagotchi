//
//  SelectCollectionViewCell.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class SelectCollectionViewCell: UICollectionViewCell {
    
    static let identity = "SelectCollectionViewCell"
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var labelView: UIView!
    
    func setCell() {
        labelView.layer.borderWidth = 0.5
        labelView.layer.borderColor = UIColor.sesacBorder.cgColor
        labelView.layer.cornerRadius = 5
        labelView.backgroundColor = .sesacBackground
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        nameLabel.backgroundColor = .sesacBackground
        nameLabel.textColor = .sesacBorder
        nameLabel.adjustsFontSizeToFitWidth = true
        
        self.backgroundColor = .sesacBackground
    }
    
}
