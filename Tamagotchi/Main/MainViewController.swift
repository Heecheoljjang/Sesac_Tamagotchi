//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class MainViewController: UIViewController {

    static let identity = "MainViewController"
    
    var name: String = ""
    
    //레벨, 밥알, 물방울
    var myTamagotchi: [String: Int] = ["level": 1, "food": 0, "water": 0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(tapSettingBtn))
        navigationItem.backButtonTitle = ""
    }
    
    // pop됐을땐 viewDidLoad가 실행되지않으므로
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentName = UserDefaults.standard.string(forKey: "name") {
            title = "\(currentName)의 다마고치"
        }
    }
    
    @objc func tapSettingBtn() {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identity) as? SettingTableViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
