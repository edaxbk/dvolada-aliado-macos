//
//  ModifierContainerCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit

class ModifierContainerCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , ModifierListener{
  
  
    
    var modifierListener : ModifierListener?
    
    var modifierInnerCell = "modifierInnerCell"
 
    var collectionViewOptions : UICollectionView!
    
    
    var titleModifier : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .clear
        text.isScrollEnabled = false
        text.sizeToFit()
        return text
    }()
    
    
    var electionModifier : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14)
        text.backgroundColor = .clear
        text.text = "Opcional"
        text.isScrollEnabled = false
        text.sizeToFit()
        return text
    }()
    
    var options = Array<Options>()
    
    
    var modifier : Modifier? {
        didSet {
            
            titleModifier.text = modifier?.title
            
            options.removeAll()
            options.append(contentsOf: (modifier?.options!)!)
            collectionViewOptions.reloadData()
            
            
            if(modifier?.isOptional != nil){
                if((modifier?.isOptional!) != nil){
                    electionModifier.text = "Opcional"
                }else{
                    electionModifier.text = "Requerido"
                }
            }else{
                electionModifier.text = "Requerido"
            }
            
            
             
        }
    }
    
    func onUpdateList(list: Array<Options>) {
        modifier!.optionsSelected = list
        modifierListener?.onUpdateList(list: list)
    }
      
    
    var optionsCollectionView : UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        
        addSubview(titleModifier)
        addSubview(electionModifier)
        
        collectionViewOptions = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewOptions.delegate = self
        collectionViewOptions.dataSource = self
        collectionViewOptions.translatesAutoresizingMaskIntoConstraints = false
        collectionViewOptions.register(ModifierInnerCell.self, forCellWithReuseIdentifier: modifierInnerCell)
        collectionViewOptions.backgroundColor = .white
        collectionViewOptions.isScrollEnabled = false
        
        addSubview(collectionViewOptions)
        
        
        
        NSLayoutConstraint.activate([
            
            titleModifier.topAnchor.constraint(equalTo: topAnchor , constant: 10),
            titleModifier.leftAnchor.constraint(equalTo: leftAnchor , constant: 10),
            titleModifier.rightAnchor.constraint(equalTo: rightAnchor , constant: -10),
            
            electionModifier.topAnchor.constraint(equalTo: titleModifier.bottomAnchor , constant: 2),
            electionModifier.leftAnchor.constraint(equalTo: leftAnchor , constant: 10),
            electionModifier.rightAnchor.constraint(equalTo: rightAnchor , constant: -10),
                      
        
            collectionViewOptions.topAnchor.constraint(equalTo: electionModifier.bottomAnchor , constant: 10),
            collectionViewOptions.leftAnchor.constraint(equalTo: leftAnchor),
            collectionViewOptions.rightAnchor.constraint(equalTo: rightAnchor),
            collectionViewOptions.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modifierInnerCell, for: indexPath) as! ModifierInnerCell
        
        cell.option = options[indexPath.item]
        cell.modifierListener = self
        cell.optionsSelected = modifier!.optionsSelected
        cell.limit = modifier?.option_selection_length ?? 1
        
        var isInList = false
        if(modifier!.optionsSelected != nil){
            
            _ = modifier!.optionsSelected!.filter { (listOption) -> Bool in
                
                if(options[indexPath.item]._id == listOption._id) {
                    isInList = true
                }
                
                return true
            }
            
            
            if(isInList){
                cell.checkbox.setCheckState(.checked, animated: false)
            }
            else{
                cell.checkbox.setCheckState(.unchecked, animated: false)
            }
            
        }
        
        
        return cell
      }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width
        return CGSize(width: width , height: CGFloat(55))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
