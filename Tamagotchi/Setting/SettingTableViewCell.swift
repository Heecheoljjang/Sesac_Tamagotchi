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
        listTitle.font = UIFont(name: "MICEGothic OTF", size: 13)
        listImg.tintColor = .sesacBorder
        detailLabel.text = ""
        detailLabel.textColor = .sesacBorder
        detailLabel.font = UIFont(name: "MICEGothic OTF", size: 13)
    }
}
