//
//  CartCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit

class CartCell : UICollectionViewCell {
    
    var order : Cart? {
        didSet {
            quantityText.text = "\(order!.quantity!)"
            dishTitle.text = order?.dish?.title
            descriptionDish.text = order?.dish!.description
            priceDish.text = "$MX\(order?.dish!.price! ?? 0).00"
        }
    }
    
    var grayContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()
    
    var quantityText : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.text = "1"
        text.textColor = .black
        text.isEditable = false
        text.isSelectable = false
        text.isUserInteractionEnabled = false
        text.isSelectable = false
        text.font = UIFont(name: "Manrope-Regular", size: 12)
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        
        return text
    }()
    
    var dishTitle : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.textColor = .black
        text.isUserInteractionEnabled = false
        text.isEditable = false
        text.isSelectable = false
        text.font = UIFont(name: "Manrope-SemiBold", size: 12)
        text.isScrollEnabled = false
        text.backgroundColor = .white
        
        return text
    }()
    
    
    
    var descriptionDish : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.isEditable = false
        text.isSelectable = false
        text.isUserInteractionEnabled = false
        text.textColor = .black
        text.isScrollEnabled = false
        text.backgroundColor = .white
        text.font = UIFont(name: "Manrope-Regular", size: 12)
        
        return text
    }()
    
    
    var priceDish : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.isEditable = false
        text.isSelectable = false
        text.textColor = .black
        text.isScrollEnabled = false
        text.isUserInteractionEnabled = false
        text.backgroundColor = .white
        text.font = UIFont(name: "Manrope-Regular", size: 14)
        
        return text
    }()
    
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
        addSubview(grayContainer)
        addSubview(dishTitle)
        addSubview(descriptionDish)
        addSubview(priceDish)
        
        
        NSLayoutConstraint.activate([
            
            grayContainer.topAnchor.constraint(equalTo: topAnchor , constant: 20),
            grayContainer.leftAnchor.constraint(equalTo: leftAnchor , constant: 30),
            grayContainer.widthAnchor.constraint(equalToConstant: 30),
            grayContainer.heightAnchor.constraint(equalToConstant: 30),
            
            dishTitle.topAnchor.constraint(equalTo: topAnchor , constant: 10),
            dishTitle.leftAnchor.constraint(equalTo: grayContainer.rightAnchor , constant: 10),
            dishTitle.rightAnchor.constraint(equalTo: rightAnchor , constant: -30),
            
            descriptionDish.topAnchor.constraint(equalTo: dishTitle.bottomAnchor , constant: 0),
            descriptionDish.leftAnchor.constraint(equalTo: dishTitle.leftAnchor),
            descriptionDish.rightAnchor.constraint(equalTo: rightAnchor , constant: -60),
            
            
            priceDish.topAnchor.constraint(equalTo: topAnchor , constant: 15),
            priceDish.rightAnchor.constraint(equalTo: rightAnchor , constant: -25),
            
        ])
        
        
        grayContainer.addSubview(quantityText)
        
        NSLayoutConstraint.activate([
            quantityText.centerXAnchor.constraint(equalTo: grayContainer.centerXAnchor),
            quantityText.centerYAnchor.constraint(equalTo: grayContainer.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
