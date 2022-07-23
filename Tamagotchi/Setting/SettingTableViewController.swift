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
        
        cell.listImg.image = UIImage(named: settingList.settingLists[indexPath.row].leftImg)
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
            // push로 셀렉션뷰 띄우고 타이틀은 다마고치 변경하기 -> 이후는 detailview에서 설정
            let sb = UIStoryboard(name: "Select", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: SelectCollectionViewController.identity) as? SelectCollectionViewController else { return }
            
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
                        
                let sb = UIStoryboard(name: "Select", bundle: nil)
                guard let vc = sb.instantiateViewController(withIdentifier: SelectCollectionViewController.identity) as? SelectCollectionViewController else { return }
                
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                
                vc.navTitle = "다마고치 선택하기"
                
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
        return CGFloat(44)
    }
}
