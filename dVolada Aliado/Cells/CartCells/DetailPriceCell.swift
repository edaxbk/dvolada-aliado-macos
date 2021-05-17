//
//  DetailPriceCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import Foundation
import UIKit


class DetailPriceCell: UICollectionViewCell {
    
    
    var price : Price? {
        didSet {
            conceptTitle.text = price!.title
            priceTitle.text = "$MX\(price!.price!).00"
        }
    }
    
      var conceptTitle : UITextView = {
         
         let text = UITextView()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.sizeToFit()
         text.textColor = .black
         text.isScrollEnabled = false
         text.font = UIFont(name: "Manrope-Regular", size: 14)
         text.backgroundColor = .white
         
         return text
     }()
     
     
     
     var priceTitle : UITextView = {
         
         let text = UITextView()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.sizeToFit()
         text.textAlignment = .right
         text.textColor = .black
         text.isScrollEnabled = false
         text.backgroundColor = .white
         text.font = UIFont(name: "Manrope-Regular", size: 14)
         
         return text
     }()
     
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(conceptTitle)
        addSubview(priceTitle)
        
        NSLayoutConstraint.activate([
            conceptTitle.topAnchor.constraint(equalTo: topAnchor , constant: 10),
            conceptTitle.leftAnchor.constraint(equalTo: leftAnchor , constant: 30),
            conceptTitle.widthAnchor.constraint(equalToConstant: 200),
            
            
            priceTitle.topAnchor.constraint(equalTo: topAnchor , constant: 10),
            priceTitle.rightAnchor.constraint(equalTo: rightAnchor , constant: -30),
            priceTitle.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
