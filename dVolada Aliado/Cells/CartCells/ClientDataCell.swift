//
//  ClientDataCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit


class ClientDataCell: UICollectionViewCell {
    
    
    let titlePaymentLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Cliente"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    let addDataclientButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Ingresar datos del cliente", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()    
        
    let nameclientLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Agregar datos del cliente"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = UIColor(red: 0.65, green: 0.69, blue: 0.71, alpha: 1.00)
        
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titlePaymentLabel)
        addSubview(nameclientLabel)
        addSubview(addDataclientButton)
        
        NSLayoutConstraint.activate([
            
            titlePaymentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titlePaymentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titlePaymentLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            
            nameclientLabel.topAnchor.constraint(equalTo: titlePaymentLabel.bottomAnchor, constant: 15),
            nameclientLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            nameclientLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            addDataclientButton.topAnchor.constraint(equalTo: nameclientLabel.bottomAnchor, constant: 15),
            addDataclientButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addDataclientButton.widthAnchor.constraint(equalToConstant: 200),
            addDataclientButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
        addDataclientButton.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
