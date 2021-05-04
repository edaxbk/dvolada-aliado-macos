//
//  DishMenuStoreList.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 29/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class DishMenuStoreListCell: UITableViewCell {
    
    var ordenID = "ordenid"
    
    var dishes : Dish? {
        didSet{
            
            if (dishes?.isAvailable) == true{
                isAvailableLabel.text = "Activado"
            }else{
                isAvailableLabel.text = "Desactivado"
            }
            
            namedishLabel.text = dishes?.title
            descDishLabel.text = dishes?.description
            
            if let p = dishes?.price {
                priceLabel.text = "MX$\(String(format: "%.2f",Float(p)))"
            }
            
            if let image = dishes?.images?.first {
                if !image.isEmpty{
                    dishImage.loadImage(url: String(image))
                }
            }
        }
    }
    
    let isAvailableLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Activado"
        label.textAlignment = .right
        label.backgroundColor =  .clear
        return label
    }()
    
    let namedishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "Platillo"
        label.backgroundColor = .clear
        return label
    }()
    
    let descDishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(18)
        label.text = "Descripcion"
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.backgroundColor =  .white
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "MX$100.00"
        return label
    }()
    
    var dishImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        selectionStyle = .none
        //Agregamos a la subvista el objeto y lo ubicamos
        addSubview(isAvailableLabel)
        addSubview(namedishLabel)
        addSubview(descDishLabel)
        addSubview(priceLabel)
        addSubview(dishImage)
        
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            namedishLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            namedishLabel.heightAnchor.constraint(equalToConstant: 40),
            namedishLabel.leftAnchor.constraint(equalTo: leftAnchor),
            namedishLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -100),
            
            isAvailableLabel.topAnchor.constraint(equalTo: topAnchor),
            isAvailableLabel.rightAnchor.constraint(equalTo: rightAnchor),
            isAvailableLabel.heightAnchor.constraint(equalToConstant: 40),
            isAvailableLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            
            descDishLabel.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor, constant: 5),
            descDishLabel.leftAnchor.constraint(equalTo: leftAnchor),
            descDishLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -150),
            descDishLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            descDishLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor,constant: 5),
            
            priceLabel.topAnchor.constraint(equalTo: descDishLabel.bottomAnchor,constant: 20),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor),
            priceLabel.widthAnchor.constraint(equalTo: widthAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 40),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
                       
            dishImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            dishImage.rightAnchor.constraint(equalTo: rightAnchor),
            dishImage.widthAnchor.constraint(equalToConstant: 120),
            dishImage.heightAnchor.constraint(equalToConstant: 120),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
