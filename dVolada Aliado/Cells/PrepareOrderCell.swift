//
//  File.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit


class PrepareOrderCell: UICollectionViewCell {
    
    var ordenID = "ordenid"
    
    //    var onden : Order? {
    //        didSet{
    //            nameLabel.text = onden?.name
    //            idLabel.text = onden?.id
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
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ari Valencia"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let btnStatus : UIButton = {
        let btn = UIButton ()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9168758096, green: 0.8632928995, blue: 0.2570806219, alpha: 1)
        //btn.layer.cornerRadius = 20
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
        
        
        addConstraintsWhitFormat(format: "H:|-16-[v0(100)][v1(150)][v2(80)]|", views: idLabel,nameLabel,btnStatus)
        addConstraintsWhitFormat(format: "V:|[v0]|", views: idLabel)
        addConstraintsWhitFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWhitFormat(format: "V:|[v0]|", views: btnStatus)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

