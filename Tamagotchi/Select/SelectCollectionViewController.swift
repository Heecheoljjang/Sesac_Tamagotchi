//
//  SelectCollectionViewController.swift
//  Tamagotchi
//
//  Created by HeecheolYoon on 2022/07/22.
//

import UIKit

class SelectCollectionViewController: UICollectionViewController {

    static let identity = "SelectCollectionViewController"
    
    var tamagotchiList = TamagotchiList()
    
    var navTitle: String = ""
    
    override func viewDidLoad() {
        
        self.collectionView.backgroundColor = UIColor.sesacBackground
        
        // 컬렉션뷰 셀 레이아웃
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 6)
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        title = navTitle
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identity, for: indexPath) as? SelectCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setCell()
        
        if indexPath.item < 3 {
            cell.profileImg.image = tamagotchiList.list[indexPath.row].profileImg
            cell.nameLabel.text = tamagotchiList.list[indexPath.row].name
    
        } else {
            cell.nameLabel.text = tamagotchiList.list[3].name
            cell.profileImg.image = tamagotchiList.list[3].profileImg
        }
        
        return cell
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
