//
//  FinishedOrderCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class FinishedORderCell: UICollectionViewCell {
    
    var ordenID = "ordenid"
          
    var order : Order? {
        didSet{
//            nameLabel.text = order?.name
//            idLabel.text = order?.id
        }
    }
      
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
   let titleLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orden rechazada porel negocio"
        label.textColor = .red
        //label.textAlignment = .center
        return label
    }()
    
    

    let idLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5f59334"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel : UILabel = {
         let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          label.text = "Ari Valencia"
        label.font = label.font.withSize(20)
        label.textColor = .black
          return label
      }()
      
    
   
    func setupViews(){
        //Agregamos a la subvista el objeto y lo ubicamos
        addSubview(idLabel)
         addSubview(nameLabel)
        
        //addSubview(titleLabel)
        
       // addConstraintsWhitFormat(format: "H:|-12-[v0]-16-|", views: titleLabel)
        //addConstraintsWhitFormat(format: "V:|[v0]|", views: titleLabel)
       addConstraintsWhitFormat(format: "H:|-16-[v0(100)][v1]-16-|", views: idLabel,nameLabel)
        addConstraintsWhitFormat(format: "V:|[v0]|", views: idLabel)
         addConstraintsWhitFormat(format: "V:|[v0]|", views: nameLabel)
        idLabel.frame = CGRect(x: 0,y: 0,width: frame.width,height: 150)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

