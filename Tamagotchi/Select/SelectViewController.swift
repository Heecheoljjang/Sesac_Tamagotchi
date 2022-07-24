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
    
    var navTitle: String = ""
    
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
        layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.minimumLineSpacing = spacing
        listCollectionView.collectionViewLayout = layout
        
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
        
        cell.setCell()
        
        if indexPath.item < 3 {
            cell.profileImg.image = UIImage(named: tamagotchiList.list[indexPath.row].profileImg)
            cell.nameLabel.text = tamagotchiList.list[indexPath.row].name
    
        } else {
            cell.nameLabel.text = tamagotchiList.list[3].name
            cell.profileImg.image = UIImage(named: tamagotchiList.list[3].profileImg)
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identity) as? DetailViewController else { return }
        
        if indexPath.item < 3 {
            
            vc.tamagotchiData = tamagotchiList.list[indexPath.item]
            
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        } else {
            showAlert(title: "준비중입니다!!!")
        }
    }
    
}
