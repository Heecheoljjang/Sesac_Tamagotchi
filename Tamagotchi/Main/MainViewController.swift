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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //네비게이션 타이틀
        title = "\(name)의 다마고치"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(tapSettingBtn))
        navigationItem.backButtonTitle = ""
    }
    
    @objc func tapSettingBtn() {
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identity) as? SettingTableViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
