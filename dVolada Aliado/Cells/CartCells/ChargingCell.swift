//
//  ChargingCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit


var priceIdentifier = "priceIdentifier"


class ChargingCell : UICollectionViewCell ,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var subTotal = 0 {
        didSet {
            collectionViewPrices.reloadData()
        }
    }
    
    var fee = 0 {
        didSet {
            collectionViewPrices.reloadData()
        }
    }
    
    
    
    var collectionViewPrices : UICollectionView!
    
    let grayLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()
    
    
    let grayBottonLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(grayLine)
        
        
        collectionViewPrices = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewPrices.delegate = self
        collectionViewPrices.dataSource = self
        collectionViewPrices.translatesAutoresizingMaskIntoConstraints = false
        collectionViewPrices.register(DetailPriceCell.self, forCellWithReuseIdentifier: priceIdentifier)
        collectionViewPrices.backgroundColor = .white
        collectionViewPrices.isScrollEnabled = false
        
        
        addSubview(collectionViewPrices)
        
        addSubview(grayBottonLine)
        
        
        NSLayoutConstraint.activate([
            
            grayLine.topAnchor.constraint(equalTo: topAnchor),
            grayLine.leftAnchor.constraint(equalTo: leftAnchor , constant: 15),
            grayLine.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            grayLine.heightAnchor.constraint(equalToConstant: 1),
            
            collectionViewPrices.topAnchor.constraint(equalTo: grayLine.bottomAnchor, constant: 5),
            collectionViewPrices.leftAnchor.constraint(equalTo: leftAnchor),
            collectionViewPrices.rightAnchor.constraint(equalTo: rightAnchor),
            collectionViewPrices.heightAnchor.constraint(equalToConstant: 130),
            
            grayBottonLine.topAnchor.constraint(equalTo: collectionViewPrices.bottomAnchor),
            grayBottonLine.leftAnchor.constraint(equalTo: leftAnchor , constant: 15),
            grayBottonLine.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            grayBottonLine.heightAnchor.constraint(equalToConstant: 1),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let priceCell = collectionView.dequeueReusableCell(withReuseIdentifier: priceIdentifier, for: indexPath) as! DetailPriceCell
        
        let price = Price()
        
        if(indexPath.item == 0){
            price.title = "Subtotal"
            price.price = subTotal
        }else if(indexPath.item == 1){
            price.title = "Envio"
            price.price = fee
        }else if(indexPath.item == 2){
            price.title = "Total"
            price.price = fee + subTotal
        }
        
        
        priceCell.price = price
        
        return priceCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 25)
    }
    
    
}
