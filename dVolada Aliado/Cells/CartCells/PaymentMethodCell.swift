//
//  PaymentMethodCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit


class PaymentMethodCell : UICollectionViewCell {
    
    
    let titlePaymentLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Metodo de pago"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    let descriptionPaymentLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Efectivo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.65, green: 0.69, blue: 0.71, alpha: 1.00)
        
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titlePaymentLabel)
        addSubview(descriptionPaymentLabel)
        
        NSLayoutConstraint.activate([
            
            titlePaymentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titlePaymentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titlePaymentLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            
            descriptionPaymentLabel.topAnchor.constraint(equalTo: titlePaymentLabel.bottomAnchor, constant: 33),
            descriptionPaymentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionPaymentLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
