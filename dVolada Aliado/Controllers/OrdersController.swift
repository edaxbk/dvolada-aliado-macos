//
//  OrdersController.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 18/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class OrdersController: UICollectionViewController ,  UICollectionViewDelegateFlowLayout{
    
    var headerOrderCellID = "headerOrderCellID"
    var bodyOrderCellID = "bodyOrderCellID"
    
    var orderListener : OrderListener?
    var headerListener : HeaderListener?
    
    
    var listOfOrders = Array<Order>() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var titleTab : String? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
                
        
        registerCells()
        
        if #available(iOS 11.0, *) {
            if let top = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                collectionView.contentInset = UIEdgeInsets(top: -top, left: 0, bottom: 0, right: 0)
            }
        } else {
            collectionView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        }
    }
    
    func registerCells(){
        collectionView.register(HeaderOrderCell.self, forCellWithReuseIdentifier: headerOrderCellID)
        collectionView.register(OrderListCell.self, forCellWithReuseIdentifier: bodyOrderCellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated:true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.item == 0){
            
            switch UIDevice.current.userInterfaceIdiom {
             case .phone:
                 // It's an iPhone
                return CGSize(width: view.frame.width, height: 100)
             case .pad:
                 // It's an iPad (or macOS Catalyst)
                return CGSize(width: view.frame.width, height: 200)
             case .unspecified:
                 // Uh, oh! What could it be?
                break
            case .tv:
                break
            case .carPlay:
                break
            case .mac:
                break
            @unknown default:
                break
            }

            
            return CGSize(width: view.frame.width, height: 200)
        }
        else if(indexPath.item == 1){
            let height = listOfOrders.count * 170
            return CGSize(width: view.frame.width, height: CGFloat(height))
        }
        
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.item == 0){
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: headerOrderCellID, for: indexPath) as! HeaderOrderCell
            
            headerCell.titleTab = titleTab
            headerCell.listener = headerListener
            
            return headerCell
        }else if(indexPath.item == 1){
            let orderListCell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyOrderCellID, for: indexPath) as! OrderListCell
            orderListCell.listOfOrders = listOfOrders
            orderListCell.listener = orderListener
            return orderListCell
        }
        
        
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: headerOrderCellID, for: indexPath)
        return defaultCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
}
