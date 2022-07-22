//
//  SettingTableViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class SettingTableViewController: UITableViewController {

    var settingList = SettingLists()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.settingLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identity, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.listImg.image = settingList.settingLists[indexPath.row].leftImg
        cell.listImg.tintColor = .sesacBorder
        cell.listTitle.text = settingList.settingLists[indexPath.row].listTitle
        cell.listTitle.font = .boldSystemFont(ofSize: 13)
        cell.detailLabel.text = settingList.settingLists[indexPath.row].detailLabel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
}
