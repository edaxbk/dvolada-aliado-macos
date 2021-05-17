//
//  ModifierCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit


class ModifierCell : UICollectionViewCell, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var collectionViewDish : UICollectionView!

    var modifierCell = "modifierCell"
    
    
    var modifierListener : ModifierListener?
    
    var list = Array<Modifier>() {
        didSet {
            collectionViewDish.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        
        backgroundColor = .white
                
        collectionViewDish = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewDish.delegate = self
        collectionViewDish.dataSource = self
        collectionViewDish.translatesAutoresizingMaskIntoConstraints = false
        collectionViewDish.register(ModifierContainerCell.self, forCellWithReuseIdentifier: modifierCell)
        collectionViewDish.backgroundColor = .white
        collectionViewDish.isScrollEnabled = false
        
        addSubview(collectionViewDish)
        
        NSLayoutConstraint.activate([
            collectionViewDish.topAnchor.constraint(equalTo: topAnchor),
            collectionViewDish.leftAnchor.constraint(equalTo: leftAnchor),
            collectionViewDish.rightAnchor.constraint(equalTo: rightAnchor),
            collectionViewDish.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modifierCell, for: indexPath) as! ModifierContainerCell
        cell.modifier = list[indexPath.item]
        cell.modifierListener = modifierListener

        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        var height = 500
        
        if list.count > indexPath.count {
            height = list[indexPath.count].options!.count * 230
        }
        
        
        let width = frame.width
        
        return CGSize(width: width , height: CGFloat(height))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
