//
//  MenuStoreController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

class MenuStoreController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var menus = Array<Menu>()
    var listener : DirectionsListener?
    var direction : Direction?
    
    var store : Store? {
        didSet{
            
            navigationItem.title = store?.name
            collectionView.reloadData()
            
            ServerHelper.shared.getMenuFromStore(id: (store?._id!)!) { (list) in
                
                //self.completeHeightMenu = 0
                /*
                list.forEach { (menu) in
                    self.completeHeightMenu = self.completeHeightMenu + (menu.menu!.count * 130)
                }*/
                
                
                self.menus.append(contentsOf: list)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
    let cantidadLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    let addCartBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(15)
        btn.setTitle("Ver Carrito", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.009940003735, green: 0.7379371762, blue: 0.05223868774, alpha: 1)
        btn.tintColor = .white
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.backgroundColor = #colorLiteral(red: 0.9274611399, green: 0.9274611399, blue: 0.9274611399, alpha: 1)
        collectionView.register(SupView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "YourID")
        collectionView.register(MenuStoreTripCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.contentInset = UIEdgeInsets (top:10 ,left: 0,bottom: 80,right: 0)
        
       
        collectionView.addSubview(addCartBtn)
            addCartBtn.addSubview(cantidadLabel)
            NSLayoutConstraint.activate([
                addCartBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                addCartBtn.leftAnchor.constraint(equalTo: view.leftAnchor),
                addCartBtn.rightAnchor.constraint(equalTo: view.rightAnchor),
                addCartBtn.heightAnchor.constraint(equalToConstant: 80),
                
                cantidadLabel.centerYAnchor.constraint(equalTo: addCartBtn.centerYAnchor),
                cantidadLabel.rightAnchor.constraint(equalTo: addCartBtn.rightAnchor,constant: -20),
            ])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10,left: 0,bottom: 20 ,right: 0)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return menus[section].menu!.count
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! MenuStoreTripCell
        //cell.dishes = menus[indexPath.section].menu?[indexPath.item]
        cell.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20,height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productController = ProductMenuTripsController()
        //productController.dishes = menus[indexPath.section].menu?[indexPath.item]
        navigationController?.pushViewController(productController, animated: true)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menus.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind:  kind, withReuseIdentifier: "YourID", for: indexPath) as! SupView
        //headerView.namedishLabel.text = "\((menus[indexPath.section].title)!)"
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 50)
    }

}

