//
//  ModifierInnerCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import M13Checkbox
import UIKit

class ModifierInnerCell : UICollectionViewCell {
    
    var optionsSelected : Array<Options>?
    var modifierListener : ModifierListener?
    var limit = 1
    
    var titleOption : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14)
        text.backgroundColor = .white
        text.isEditable = false
        text.isSelectable = false
        text.textColor = .black
        text.isScrollEnabled = false
        text.sizeToFit()
        return text
    }()
    
    
    
    
    public let SELECTION_RANGE = 0
    
    var feePrice : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14)
        text.isEditable = false
        text.isSelectable = false
        text.backgroundColor = .white
        text.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.00)
        text.isScrollEnabled = false
        text.sizeToFit()
        return text
    }()
    
    var grayLine : UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.00)
        
        return view
        
    }()
    
    
    var option : Options? {
        didSet {
            titleOption.text = option?.name
            feePrice.text = "$\(option!.fee!).00"
        }
    }
    
    
    var checkbox : M13Checkbox!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        checkbox = M13Checkbox(frame: CGRect.zero)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(titleOption)
        addSubview(feePrice)
        addSubview(grayLine)
        addSubview(checkbox)
        
        NSLayoutConstraint.activate([
            
            checkbox.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
            checkbox.topAnchor.constraint(equalTo: topAnchor , constant: 25),
            checkbox.widthAnchor.constraint(equalToConstant: 20),
            checkbox.heightAnchor.constraint(equalToConstant: 20),
            
            titleOption.topAnchor.constraint(equalTo: topAnchor , constant: 17),
            titleOption.leftAnchor.constraint(equalTo: leftAnchor , constant: 50),
            titleOption.rightAnchor.constraint(equalTo: rightAnchor , constant: -50),
            
            
            feePrice.topAnchor.constraint(equalTo: topAnchor , constant: 15),
            feePrice.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            grayLine.topAnchor.constraint(equalTo: feePrice.bottomAnchor , constant: 15),
            grayLine.heightAnchor.constraint(equalToConstant: 1),
            grayLine.leftAnchor.constraint(equalTo: leftAnchor , constant: 50),
            grayLine.rightAnchor.constraint(equalTo: rightAnchor , constant: -10)
            
            
        ])
        
        
        checkbox.checkedValue = true
        checkbox.uncheckedValue = false
        checkbox.mixedValue = 0.5
        checkbox.isEnabled = false
        
        checkbox!.addTarget(self, action: #selector(self.checkboxValueChanged(_:)), for: .valueChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        addGestureRecognizer(tap)
        
    }
    
    
    @objc func handleGesture(gesture: UITapGestureRecognizer) -> Void {
        checkbox.toggleCheckState()
        checkboxValueChanged(checkbox)
    }
    
    @objc func checkboxValueChanged(_ sender: M13Checkbox) {
        print("VALUE CHANGED")
        
        if(checkbox.value as! Bool){
            if (limit == SELECTION_RANGE) {
                optionsSelected?.append(option!)
            } else if (optionsSelected!.count < limit) {
                optionsSelected?.append(option!)
            }else{
                //Can't add, but he's going to replace option.
                optionsSelected?.removeAll()
                optionsSelected?.append(option!)
            }
            
            modifierListener!.onUpdateList(list: optionsSelected!)
            
        }else{
            
            
            let newList = optionsSelected!.filter { (listOption) -> Bool in
                return listOption._id != option!._id
            }
            
            
            print("LIST OPTIONS IS REMOVING")
            print(newList)
            
            
            modifierListener!.onUpdateList(list: newList)
            
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

