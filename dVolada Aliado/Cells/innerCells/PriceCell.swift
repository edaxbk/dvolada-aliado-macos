//
//  PriceCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit


class PriceCell: UICollectionViewCell {
    
    
    let titleConceptLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "Manrope-Semibold", size: 15)
        label.numberOfLines = 3
        label.text = "Subtotal:"
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = UIColor(red: 0.10, green: 0.18, blue: 0.31, alpha: 1.00)

        return label
    }()
    
    
    let titlePriceLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "Manrope-Semibold", size: 15)
        label.numberOfLines = 3
        label.text = "$20.00"
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = UIColor(red: 0.10, green: 0.18, blue: 0.31, alpha: 1.00)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleConceptLabel)
        addSubview(titlePriceLabel)
        
        NSLayoutConstraint.activate([
            
            titleConceptLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleConceptLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titlePriceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titlePriceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
