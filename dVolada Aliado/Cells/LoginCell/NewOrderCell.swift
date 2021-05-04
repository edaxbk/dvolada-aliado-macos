//
//  NewOrderCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 26/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class NewOrderCell: UICollectionViewCell {

  
   
    override init(frame: CGRect) {
        super.init(frame: frame)

     
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(viewOrderBtn)
     
    
          NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: frame.height/4),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor , constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
    
            descLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            descLabel.heightAnchor.constraint(equalToConstant: 80),
           
                        
            viewOrderBtn.topAnchor.constraint(equalTo: descLabel.bottomAnchor,constant: 50),
            viewOrderBtn.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            viewOrderBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            viewOrderBtn.heightAnchor.constraint(equalToConstant: frame.height / 12),
           
          ])
      
        }
    
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }



