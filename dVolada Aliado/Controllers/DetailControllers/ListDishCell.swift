//
//  ListDish.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 18/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class ListDishCell: UICollectionViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var dishID = "categoryID"
    var cart = Array<Cart>() {
        didSet {
            listDishCollectionView.reloadData()
        }
    }
    
    var listDishCollectionView : UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        listDishCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        listDishCollectionView.translatesAutoresizingMaskIntoConstraints = false
        listDishCollectionView.register(DishCell.self, forCellWithReuseIdentifier: dishID)
        listDishCollectionView.delegate = self
        listDishCollectionView.dataSource = self
        listDishCollectionView.backgroundColor = .white
        
        addSubview(listDishCollectionView)
        
        
        NSLayoutConstraint.activate([
            listDishCollectionView.topAnchor.constraint(equalTo: topAnchor),
            listDishCollectionView.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
            listDishCollectionView.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            listDishCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("RETURING CART \(cart.count)")
        return cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dishID, for: indexPath) as! DishCell
        cell.cart = cart[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 80)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
