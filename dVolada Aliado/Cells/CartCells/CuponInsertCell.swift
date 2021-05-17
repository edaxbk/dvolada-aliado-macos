//
//  CuponInsertCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit


class CuponInsertCell: UICollectionViewCell {
    
    
    let titlePaymentLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Cupon de descuento"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    
    
    let editButton : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icons8-edit-50"), for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.00)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleEditButton(){
        
    }
    
    
    let descriptionPaymentLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Sin cupon de descuento"
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
        addSubview(editButton)
        
        NSLayoutConstraint.activate([
            
            titlePaymentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titlePaymentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titlePaymentLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            
            descriptionPaymentLabel.topAnchor.constraint(equalTo: titlePaymentLabel.bottomAnchor, constant: 33),
            descriptionPaymentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionPaymentLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            
            editButton.topAnchor.constraint(equalTo: titlePaymentLabel.bottomAnchor, constant: 15),
            editButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 45),
            editButton.widthAnchor.constraint(equalToConstant: 45)
            
        ])
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
