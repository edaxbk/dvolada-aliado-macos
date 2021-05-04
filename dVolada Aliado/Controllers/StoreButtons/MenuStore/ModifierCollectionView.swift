//
//  ModificadorController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
/*

import UIKit
class ModifierCollectionView: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var modificadorID = "modificadorID"
    
    var modifiers = Array<Modifier>()
    
    override func viewWillAppear(_ animated: Bool) {
        
        ServerHelper.shared.getModifiersStore(id: (LocalHelper.shared.getClient()?._id)!) { (getModifiers) in
            self.modifiers.removeAll()
            self.modifiers.append(contentsOf: getModifiers)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
   
   override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .green
    
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.addTarget(self, action: #selector(addDishBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    
        navigationItem.title = "Modificadores"
        collectionView.register(ModificadorCell.self, forCellWithReuseIdentifier: modificadorID)
        collectionView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return modifiers.count
       }
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modificadorID, for: indexPath) as! ModificadorCell
            cell.modificador = modifiers[indexPath.item]
            return cell
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: view.frame.width - 20,height: 200)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 20
       }
    
    @objc func addDishBtn(_sender : UIButton) {
      //let modificadorController = AddNewModificadorControll()
      //navigationController?.pushViewController(modificadorController, animated: true)
    }
    

}



    */
