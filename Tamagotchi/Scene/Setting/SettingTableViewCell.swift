//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/23.
//

import UIKit

class SettingTableViewCell: UITableViewCell, Identity {

    static var identity = String(describing: SettingTableViewCell.self)
    
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
    
    func setCellUI() {
        backgroundColor = .sesacBackground
        listTitle.font = UIFont(name: "MICEGothic OTF", size: 13)
        listImageView.tintColor = .sesacBorder
        detailLabel.text = ""
        detailLabel.textColor = .sesacBorder
        detailLabel.font = UIFont(name: "MICEGothic OTF", size: 13)
    }
}
