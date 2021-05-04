//
//  DetailPendingOrderCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.

import UIKit
import SCLAlertView
import JGProgressHUD


class DetailOrderController : UICollectionViewController , UICollectionViewDelegateFlowLayout, TimeListener{
   
    
    var listener : OrderInvitationListener?
    var dishID = "categoryID"
    var estimateTime = ""
    let orderID = "ordenID"
    
    var order : Order? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(HeaderDetails.self, forCellWithReuseIdentifier: "hid")
        collectionView.register(ListDishCell.self, forCellWithReuseIdentifier: dishID)
        collectionView.register(FooterDetails.self, forCellWithReuseIdentifier: "gid")
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let headerDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "hid", for: indexPath) as! HeaderDetails
            headerDetailsCell.order = order
            return headerDetailsCell
        case 1 :
            let dishCell = collectionView.dequeueReusableCell(withReuseIdentifier: dishID, for: indexPath) as! ListDishCell
            dishCell.cart = order?.cart ?? Array<Cart>()
            return dishCell
        case 2 :
            let footerDetailsCells = collectionView.dequeueReusableCell(withReuseIdentifier: "gid", for: indexPath) as! FooterDetails
            footerDetailsCells.order = order
            footerDetailsCells.timeListener = self
            footerDetailsCells.confirmBtn.addTarget(self, action: #selector(handleClickAcceptOrder), for: .touchUpInside)
            footerDetailsCells.denyBtn.addTarget(self, action: #selector(rejectOrder), for: .touchUpInside)
            footerDetailsCells.confirmBtn.tag = indexPath.item
            return footerDetailsCells
        default:
            break
        }
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
        return defaultCell
    }
    
    

    @objc func handleClickAcceptOrder(_sender : UIButton) {
        if(!estimateTime.isEmpty){
            
            let hud = JGProgressHUD()
            hud.textLabel.text = "Aceptando Orden"
            hud.show(in: self.view)
            
            order?.estimatedTime = estimateTime
            order?.status = "STORE_PREPARING"
            
            ServerHelper.shared.updateStatusOnTransaction(transaction: order!) {
                hud.dismiss()
                self.listener?.onOrderAccepted()
                self.dismiss(animated: true, completion: nil)
            } onError: {
                hud.dismiss()
                SCLAlertView().showError("Alerta", subTitle: "Se necesita el tiempo estimado") // Error
            }
            
            navigationController?.popViewController(animated: true)
        }else{
            SCLAlertView().showError("Alerta", subTitle: "Se necesita el tiempo estimado") // Error
        }
    }
    
    @objc func rejectOrder() {
        
        let hud = JGProgressHUD()
        hud.textLabel.text = "Rechazando Orden"
        hud.show(in: self.view)
        
        order?.status = "STORE_REJECTED"
        
        ServerHelper.shared.updateStatusOnTransaction(transaction: order!) {
            hud.dismiss()
            self.listener?.onOrderRejected()
            self.dismiss(animated: true, completion: nil)
        } onError: {
            hud.dismiss()
            SCLAlertView().showError("Alerta", subTitle: "Se necesita el tiempo estimado") // Error
        }

        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: view.frame.width - 20, height: 180)
        case 1 :
            return CGSize(width: view.frame.width , height: CGFloat(order!.cart!.count * 82))
        case 2 :
            return CGSize(width: view.frame.width, height: 180)
        default:
            break
        }
        return CGSize(width: view.frame.width, height: 100)
        
    }
    

    func onTimeListener(timeEstimate: String) {
        self.estimateTime = timeEstimate
    }
    
    
    
}

