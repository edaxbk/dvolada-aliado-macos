//
//  PendingOrderCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class OrderCell: UICollectionViewCell {
    
    var ordenID = "ordeId"
    
    var order : Order? {
        didSet{
            if(order?._id != nil){
                idLabel.text = String((order?._id?.prefix(6))!)
                nameLabel.text = order?.client?.complete_name
            }
            
        }
    }
    
    let idLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "id"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
      }()

      override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.30, green: 0.69, blue: 0.31, alpha: 1.00)
        

    
        addSubview(idLabel)
        addSubview(nameLabel)
        addConstraintsWhitFormat(format: "H:|-16-[v0(100)][v1]-16-|", views: idLabel,nameLabel)
        addConstraintsWhitFormat(format: "V:|[v0]|", views: idLabel)
        addConstraintsWhitFormat(format: "V:|[v0]|", views: nameLabel)

        idLabel.frame = CGRect(x: 0,y: 0,width: frame.width,height: 150)
          
      }
        
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

}
