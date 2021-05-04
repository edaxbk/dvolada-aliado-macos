//
//  DirectionItemCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 01/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit


class DirectionItemCell : UICollectionViewCell {
    
    
    var customHeightAnchor : NSLayoutConstraint? = nil
    var topMarginAnchor : NSLayoutConstraint? = nil
    
    
    var direction : Direction? {
        didSet {
            
            if(direction?.label == nil){
                directionCell.text = "Direccion guardado"
            }else{
                directionCell.text = direction?.label
            }
            
            descriptionTexView.text = direction?.direction
        }
        
    }
    
    
    let icon : UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = #imageLiteral(resourceName: "icons8-marker-100")
        image.isUserInteractionEnabled = false
        return image
    }()
    
    let directionCell : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Direction"
        text.font = UIFont(name: "Manrope-SemiBold", size: 14)
        text.isUserInteractionEnabled = false
        text.backgroundColor = .white
        text.textColor = .black
        text.isScrollEnabled = false
        text.isSelectable = false
        return text
        
    }()
    
    
    let descriptionTexView : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Manrope-Regular", size: 12)
        text.backgroundColor = .white
        text.isUserInteractionEnabled = false
        text.textColor = .black
        text.isScrollEnabled = false
        text.isSelectable = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(directionCell)
        addSubview(descriptionTexView)
        addSubview(icon)
        
        
        
        NSLayoutConstraint.activate([
            
            icon.topAnchor.constraint(equalTo: topAnchor , constant: 10),
            icon.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 15),
            icon.heightAnchor.constraint(equalToConstant: 15),
            
            directionCell.leftAnchor.constraint(equalTo: icon.rightAnchor , constant: 5),
            directionCell.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            directionCell.heightAnchor.constraint(equalToConstant: 24),
            
            descriptionTexView.topAnchor.constraint(equalTo: directionCell.bottomAnchor),
            descriptionTexView.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5),
            descriptionTexView.rightAnchor.constraint(equalTo: rightAnchor , constant: -30),
        ])
        
        
        topMarginAnchor = directionCell.topAnchor.constraint(equalTo: topAnchor , constant: 10)
        topMarginAnchor?.isActive = true
        
        customHeightAnchor = descriptionTexView.heightAnchor.constraint(equalToConstant: 26)
        customHeightAnchor?.isActive = true
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
