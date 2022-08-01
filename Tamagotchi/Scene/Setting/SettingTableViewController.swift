//
//  SettingTableViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class SettingTableViewController: UITableViewController, Identity {

    static var identity = String(describing: SettingTableViewController.self)
    
    let userDefaults = UserDefaults.standard
    
    var settingList = SettingLists()
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 이름을 바꾸면 다시 테이블뷰로 돌아올 때 리로드해줘야 디테일 레이블 값 바뀜
        tableView.reloadData()
        
        tableView.backgroundColor = .sesacBackground
        
    }
    
    func setUpNavigationBar() {
        title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacBorder, .font: UIFont(name: CustomFont.bold.rawValue, size: 17)! ]
        tableView.separatorColor = .sesacBorder
    }
    
    func storyboardInit(_ StoryboardName: String) -> UIStoryboard {
        UIStoryboard(name: StoryboardName, bundle: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.settingLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identity, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
                
        cell.listImageView.image = UIImage(systemName: settingList.settingLists[indexPath.row].leftImg)
        cell.listTitle.text = settingList.settingLists[indexPath.row].listTitle

        if indexPath.row == 0 {
//            cell.detailLabel.text = userDefaults.string(forKey: UserDefaultsKey.name.rawValue)!
            cell.detailLabel.text = UserDefaultsHelper.shared.name
        } else {
            cell.detailLabel.text = ""
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 이름 변경
        if indexPath.row == 0 {
            
            let sb = storyboardInit(StoryboardName.name.rawValue)
            guard let vc = sb.instantiateViewController(withIdentifier: NameViewController.identity) as? NameViewController else { return }
            
//            if let currentName = userDefaults.string(forKey: UserDefaultsKey.name.rawValue) {
//                vc.currentName = currentName
//            }
            vc.currentName = UserDefaultsHelper.shared.name
            
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            // 다마고치 변경하기
            // push로 셀렉션뷰 띄우고 타이틀은 다마고치 변경하기 -> 이후는 detailview에서 설정
            let sb = storyboardInit(StoryboardName.select.rawValue)
            guard let vc = sb.instantiateViewController(withIdentifier: SelectViewController.identity) as? SelectViewController else { return }
            
            vc.navTitle = "다마고치 변경하기"
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 2{
            // 초기화 -> alert띄우고 확인눌렀을 때, UserDefaults 지우고 첫화면으로 돌아감
            
            // alert띄우기, showAlert랑 형태가 달라서 따로 작성
            let alert = UIAlertController(title: "데이터 초기화", message: "정말로 처음부터 다시 시작하실건가요?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "웅", style: .default) { _ in
                // 화면 초기화
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene // 앱을 다시 처음부터 실행해주는 코드
                let sceneDelegate = windowScene?.delegate as? SceneDelegate // 신딜리게이트 클래스에 접근
                        
                let sb = self.storyboardInit(StoryboardName.select.rawValue)
                guard let vc = sb.instantiateViewController(withIdentifier: SelectViewController.identity) as? SelectViewController else { return }
                
                // 전체 userDefaults 삭제
                let domain = Bundle.main.bundleIdentifier!
                self.userDefaults.removePersistentDomain(forName: domain)
                
                vc.navTitle = "다마고치 선택하기"
                
                // fade애니메이션 추가
                let transition = CATransition()
                transition.type = .fade
                transition.duration = 0.3
                sceneDelegate?.window?.layer.add(transition, forKey: kCATransition)
                
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.makeKeyAndVisible()
                
            }
            let no = UIAlertAction(title: "아니아니", style: .cancel)
            alert.addAction(ok)
            alert.addAction(no)
            present(alert, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(48)
    }
}
