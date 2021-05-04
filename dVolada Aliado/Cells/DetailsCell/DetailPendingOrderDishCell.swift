//
//  DetailPendingOrderDishCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 15/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class DetailPendingORderDishCell: UICollectionViewCell {
    
     let idLabel : UILabel = {
          let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "id"
           label.textColor = .black
           label.textAlignment = .center
           return label
       }()
    
       let nameLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Nombre Repartidor"
            label.font = label.font.withSize(20)
            label.textColor = .black
            return label
         }()
    
    let btnStatus : UIButton = {
       let btn = UIButton ()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .yellow
        btn.tintColor = .black
        let img = UIImage(systemName: "checkmark")
        btn.setImage(img, for: UIControl.State.normal)
        return btn
    }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            addSubview(idLabel)
           addSubview(nameLabel)
           addSubview(btnStatus)

           addConstraintsWhitFormat(format: "H:|-16-[v0(100)][v1(150)][v2]|", views: idLabel,nameLabel,btnStatus)
           addConstraintsWhitFormat(format: "V:|[v0]|", views: idLabel)
           addConstraintsWhitFormat(format: "V:|[v0]|", views: nameLabel)
           addConstraintsWhitFormat(format: "V:|[v0]|", views: btnStatus)

           idLabel.frame = CGRect(x: 0,y: 0,width: frame.width,height: 150)
           backgroundColor = .white
    }
          
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}

