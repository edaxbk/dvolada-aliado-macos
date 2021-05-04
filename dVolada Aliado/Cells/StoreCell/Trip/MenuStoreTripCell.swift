//
//  MenuStoreTripCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class MenuStoreTripCell: UICollectionViewCell {
 
    var ordenID = "ordenid"
        
    var dishes : Dish? {
        didSet{

            namedishLabel.text = dishes?.title
            descDishLabel.text = dishes?.description
            if let p = dishes?.price {
                priceLabel.text = "MX$\(String(format: "%.2f",Float(p)))"
            }
            if let image = dishes?.images {
                if !image.isEmpty{
                    //print("Image:",(image.first)!)
//                    dishImage.loadImage(url: (image.first)!)
                }
            }
        }
    }

    let namedishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
          label.numberOfLines = 2
        label.text = "Platillo"
    return label
    }()

    let descDishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        label.text = "Descripcion"
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    return label
    }()

    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
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
          image.backgroundColor = .black
          image.layer.cornerRadius = 20
          return image
      }()

          
          override init(frame: CGRect) {
            super.init(frame: frame)
            //Agregamos a la subvista el objeto y lo ubicamos
      
            addSubview(namedishLabel)
            addSubview(descDishLabel)
            addSubview(priceLabel)
            addSubview(dishImage)
       
            
            backgroundColor = .white
            
            NSLayoutConstraint.activate([

                
                namedishLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                namedishLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 5),
                namedishLabel.widthAnchor.constraint(equalToConstant: frame.width/1.5),
                namedishLabel.heightAnchor.constraint(equalToConstant: 40),
                
                descDishLabel.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor, constant: 5),
                descDishLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 5),
                descDishLabel.widthAnchor.constraint(equalToConstant: frame.width/1.5),
                descDishLabel.heightAnchor.constraint(equalToConstant: 100),
                
                priceLabel.topAnchor.constraint(equalTo: descDishLabel.bottomAnchor,constant: 5),
                priceLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 5),
                priceLabel.widthAnchor.constraint(equalToConstant: frame.width/1.5),
                priceLabel.heightAnchor.constraint(equalToConstant: 20),
                
                
                dishImage.centerYAnchor.constraint(equalTo: centerYAnchor),
                dishImage.rightAnchor.constraint(equalTo: rightAnchor,constant: -10),
                dishImage.widthAnchor.constraint(equalToConstant: 100),
                dishImage.heightAnchor.constraint(equalToConstant: 100),
              
               
            ])

          }
            
        required init?(coder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }

    }
