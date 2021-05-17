//
//  OrderDetailCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit


var cartIdentifier = "cartIdentifier"

class OrderDetailCell : UICollectionViewCell , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var listener : CartEditListener?
    
    var cart = Array<Cart>() {
        didSet {
            collectionViewCart.reloadData()
        }
    }
    
    var titleOrder : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.text = "Tu orden"
        text.isScrollEnabled = false
        text.backgroundColor = .white
        text.isEditable = false
        text.isSelectable = false
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 18)
        
        return text
    }()
    
    let grayLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()
    
    var collectionViewCart : UICollectionView!
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleOrder)
        addSubview(grayLine)
        
        collectionViewCart = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewCart.delegate = self
        collectionViewCart.dataSource = self
        collectionViewCart.translatesAutoresizingMaskIntoConstraints = false
        collectionViewCart.register(CartCell.self, forCellWithReuseIdentifier: cartIdentifier)
        collectionViewCart.backgroundColor = .white
        collectionViewCart.isScrollEnabled = false
        
        addSubview(collectionViewCart)
        
        
        NSLayoutConstraint.activate([
            
            grayLine.topAnchor.constraint(equalTo: topAnchor),
            grayLine.leftAnchor.constraint(equalTo: leftAnchor , constant: 15),
            grayLine.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            grayLine.heightAnchor.constraint(equalToConstant: 1),
            
            titleOrder.topAnchor.constraint(equalTo: grayLine.bottomAnchor , constant: 10),
            titleOrder.leftAnchor.constraint(equalTo: leftAnchor , constant: 30),
            titleOrder.rightAnchor.constraint(equalTo: rightAnchor),
            
            collectionViewCart.topAnchor.constraint(equalTo: titleOrder.bottomAnchor , constant: -5),
            collectionViewCart.leftAnchor.constraint(equalTo: leftAnchor),
            collectionViewCart.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            collectionViewCart.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cart.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cartCell = collectionView.dequeueReusableCell(withReuseIdentifier: cartIdentifier, for: indexPath) as! CartCell
        cartCell.order = cart[indexPath.item]
        return cartCell
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        print("PRODUCT CLICK")
        listener?.onProductRequestChange(position: indexPath.item)
        
    }
    
    
}
