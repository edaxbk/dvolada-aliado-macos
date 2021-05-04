//
//  CollectedOrderCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class CollectedOrderCell: UICollectionViewCell {
    
    var ordenID = "ordenid"
    
//    var order : Order? {
//        didSet{
//            nameLabel.text = order?.name
//            idLabel.text = order?.id
//        }
//    }
    
    let idLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5f59334"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ari Valencia"
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    func setupViews(){
        
        backgroundColor = .white
        
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

