//
//  SettingTableViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class SettingTableViewController: UITableViewController {

    static let identity = "SettingTableViewController"
    
    var settingList = SettingLists()
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "설정"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 이름을 바꾸면 다시 테이블뷰로 돌아올 때 리로드해줘야 디테일 레이블 값 바뀜
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.settingLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identity, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.listImg.image = settingList.settingLists[indexPath.row].leftImg
        cell.listImg.tintColor = .sesacBorder
        cell.listTitle.text = settingList.settingLists[indexPath.row].listTitle
        cell.listTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        if indexPath.row == 0 {
            cell.detailLabel.text = UserDefaults.standard.string(forKey: "name")!
        } else {
            cell.detailLabel.text = ""
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 이름 변경
        if indexPath.row == 0 {
            
            let sb = UIStoryboard(name: "Name", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: NameViewController.identity) as? NameViewController else { return }
            
            if let currentName = UserDefaults.standard.string(forKey: "name") {
                vc.currentName = currentName
            }
            
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            // 다마고치 변경하기
            
            
        } else if indexPath.row == 2{
            // 초기화 -> UserDefaults 지우고 첫화면으로 돌아감
            
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
}
