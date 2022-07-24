//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/23.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    static let identity = "SettingTableViewCell"
    
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listImg: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    func setCellUI() {
        backgroundColor = .sesacBackground
        listTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        listImg.tintColor = .sesacBorder
        detailLabel.text = ""
        detailLabel.textColor = .sesacBorder
        detailLabel.font = .systemFont(ofSize: 13, weight: .light)
    }
}
