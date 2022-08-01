//
//  aaViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/24.
//

import UIKit

class SelectViewController: UIViewController{

    var tamagotchiList = TamagotchiList()
    
    var navTitle = "" // 다마고치 변경하기 눌렀을땐 타이틀이 다르게 떠야하므로 변수 사용
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var isAllowed = false
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 컬렉션뷰 세팅
        setUpCollectionView()
        
        // 네비게이션 바 세팅
        setUpNavigationBar()
        
        // 알림 권한 요청
        requestAuthorization()
        
    }

    //MARK: - 알림
    func requestAuthorization() {
        
        //option에는 여러개가 들어있음.
        let authorizationOption = UNAuthorizationOptions(arrayLiteral: [.sound, .alert])
        
        notificationCenter.requestAuthorization(options: authorizationOption) { success, error in
            
            //사용자가 허용했을때만 알림보냄
            if success {
                self.sendNotification()
            }
        }
    }
    
    func sendNotification() {
        
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.sound = .default
        notificationContent.title = "다마고치"
        notificationContent.subtitle = "주인님 배고파요ㅠ"
                
        var dateComponent = DateComponents()
        dateComponent.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
    //MARK: - Setting
    
    //컬렉션뷰 셀 세팅
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 6)
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing * 2.5 , left: spacing, bottom: 0, right: spacing)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.minimumLineSpacing = spacing
        listCollectionView.collectionViewLayout = layout
        
        listCollectionView.backgroundColor = UIColor.sesacBackground
    }
    
    // 네비게이션 바 세팅
    func setUpNavigationBar() {
        title = navTitle
        navigationController?.navigationBar.backgroundColor = .sesacBackground
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacBorder, .font: UIFont(name: CustomFont.bold, size: 17)! ]
        lineView.backgroundColor = .sesacBorder
        view.backgroundColor = .sesacBackground
    }
    

}

extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.reuseIdentifier, for: indexPath) as? SelectCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.item < 3 {
            cell.profileImageView.image = UIImage(named: tamagotchiList.list[indexPath.row].profileImg)
            cell.nameLabel.text = tamagotchiList.list[indexPath.row].name
//            cell.profileImageView.image = UIImage(named: TamagotchiList.allCases[indexPath.item].profileImage)
//            cell.nameLabel.text = TamagotchiList.allCases[indexPath.item].name
//
        } else {
            // 준비중인 셀
            cell.nameLabel.text = tamagotchiList.list[3].name
            cell.profileImageView.image = UIImage(named: tamagotchiList.list[3].profileImg)
//            cell.nameLabel.text = TamagotchiList.allCases[3].name
//            cell.profileImageView.image = UIImage(named: TamagotchiList.allCases[3].profileImage)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = storyboardInit(StoryboardName.detail)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.reuseIdentifier) as? DetailViewController else { return }

        if indexPath.item < 3 {
            
            // 선택한 다마고치 데이터를 DetailVC에 넘겨줌.
            vc.tamagotchiData = tamagotchiList.list[indexPath.item]
//            vc.tamagotchiData = Tamagotchi(profileImg: TamagotchiList.allCases[indexPath.item].profileImage, name: TamagotchiList.allCases[indexPath.item].name, detail: TamagotchiList.allCases[indexPath.item].detail, number: TamagotchiList)
            // 뒤의 뷰를 반투명하게 보여주려면 over로 띄워야함.
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        } else {
            showAlert(title: "준비중입니다!!!")
        }
    }
    
    func storyboardInit(_ StoryboardName: String) -> UIStoryboard {
        UIStoryboard(name: StoryboardName, bundle: nil)
    }
    
}
