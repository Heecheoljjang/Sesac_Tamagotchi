//
//  aaViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/24.
//

import UIKit

class SelectViewController: UIViewController {

    static let identity = "SelectViewController"
    
    var tamagotchiList = TamagotchiList()
    
    var navTitle: String = "" // 다마고치 변경하기 눌렀을땐 타이틀이 다르게 떠야하므로 변수 사용
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listCollectionView.backgroundColor = UIColor.sesacBackground
        
        // 컬렉션뷰 셀 레이아웃
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 6)
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing * 2.5 , left: spacing, bottom: 0, right: spacing)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.minimumLineSpacing = spacing
        listCollectionView.collectionViewLayout = layout
        
        // 네비게이션 바 세팅
        title = navTitle
        navigationController?.navigationBar.backgroundColor = .sesacBackground
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.sesacBorder ]
        lineView.backgroundColor = .sesacBorder
        view.backgroundColor = .sesacBackground
        
    }

}

extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identity, for: indexPath) as? SelectCollectionViewCell else { return UICollectionViewCell() }
        
        // 셀의 기본적인 UI
        cell.setCell()
        
        if indexPath.item < 3 {
            cell.profileImg.image = UIImage(named: tamagotchiList.list[indexPath.row].profileImg)
            cell.nameLabel.text = tamagotchiList.list[indexPath.row].name
    
        } else {
            // 준비중인 셀
            cell.nameLabel.text = tamagotchiList.list[3].name
            cell.profileImg.image = UIImage(named: tamagotchiList.list[3].profileImg)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identity) as? DetailViewController else { return }
        
        if indexPath.item < 3 {
            
            // 선택한 다마고치 데이터를 DetailVC에 넘겨줌.
            vc.tamagotchiData = tamagotchiList.list[indexPath.item]
            
            // 뒤의 뷰를 반투명하게 보여주려면 over로 띄워야함.
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        } else {
            showAlert(title: "준비중입니다!!!")
        }
    }
    
}
