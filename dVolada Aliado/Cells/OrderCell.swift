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
                                
                if( order?.status ==  "STORE_PREPARING" || order?.status ==  "DRIVER_ACCEPTED"){
                    print("Estamos en store preparing")
                    self.backgroundColor = .white
                    
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowRadius = 1.0
                    self.layer.shadowOpacity = 0.1 
                    self.layer.shadowOffset = CGSize(width: 4, height: 4)
                    self.layer.masksToBounds = false
                    
                     self.nameLabel.textColor = .black
                    self.idLabel.textColor = .black
                    
                    self.addSubview(btn)
                    
                    NSLayoutConstraint.activate([
                        
                        btn.topAnchor.constraint(equalTo: self.topAnchor ),
                        btn.widthAnchor.constraint(equalToConstant: 100),
                        btn.heightAnchor.constraint(equalTo: self.nameLabel.heightAnchor),
                        btn.rightAnchor.constraint(equalTo: self.rightAnchor),
                    
                    
                    ])
                    
                }else{
                    backgroundColor = UIColor(red: 0.30, green: 0.69, blue: 0.31, alpha: 1.00)
                }
                
            }
        }
    }
    let btn : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.layer.backgroundColor = UIColor.primaryColor.cgColor
        return button
    }()
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
        
        layer.cornerRadius = 15

    
        addSubview(idLabel)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            idLabel.topAnchor.constraint(equalTo: topAnchor),
            idLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            idLabel.widthAnchor.constraint(equalToConstant: 200),
            idLabel.leftAnchor.constraint(equalTo: leftAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.leftAnchor.constraint(equalTo: idLabel.rightAnchor ,constant: 10),
            
        
        ])
          
      }
        
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

}
