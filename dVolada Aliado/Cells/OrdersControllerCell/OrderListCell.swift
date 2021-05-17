//
//  OrderListCell.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 18/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//



import Foundation
import UIKit


class OrderListCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var orderID = "orderID"
    var ordersCollectionView : UICollectionView!
    
    
    var listener : OrderListener?
    
    var listOfOrders = Array<Order>() {
        didSet {
            ordersCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        isUserInteractionEnabled = true
        
        let layout = UICollectionViewFlowLayout()
        
        
        ordersCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        ordersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        ordersCollectionView.register(OrderCell.self, forCellWithReuseIdentifier: orderID)
        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self
        ordersCollectionView.backgroundColor = .white
        
        
        addSubview(ordersCollectionView)
        
        NSLayoutConstraint.activate([
            ordersCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            ordersCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            ordersCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            ordersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -20)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellOrder = collectionView.dequeueReusableCell(withReuseIdentifier: orderID, for: indexPath) as! OrderCell
        cellOrder.order = listOfOrders[indexPath.item]
        return cellOrder
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Order CELL SELECTED")
        listener?.onOrderSelected(order: listOfOrders[indexPath.item], position: indexPath.item)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 50, height: 120)
    }
    
}




