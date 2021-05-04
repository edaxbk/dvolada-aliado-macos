//
//  TripsStoreCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 29/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit
import MapKit
class TripsStoreCell: UICollectionViewCell {
    
     var ordenID = "ordenid"
    
      var dishes : Dish? {
          didSet{
                    
            if (dishes?.isAvailable) == true{
                isAvailableLabel.text = "Activado"
            }else{
                isAvailableLabel.text = "Desactivado"
            }
//            namedishLabel.text = dishes?.name
//            descDishLabel.text = dishes?.descripcion
//            priceLabel.text = dishes?.price
           
          }
      }

    
    let isAvailableLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "TRIPS SCREEN"
        label.textAlignment = .right
        label.backgroundColor = .green
    return label
    }()
    
    let mapita : MKMapView = {
        let map = MKMapView()
        map.backgroundColor = .black
       return map
    }()

    let namedishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Platillo"
        label.backgroundColor = .blue
    return label
    }()

    let descDishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(10)
        label.text = "Descripcion"
        label.textAlignment = .center
        label.backgroundColor = .yellow
    return label
    }()

    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.text = "MX$100.00"
        label.backgroundColor = .green
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
          image.layer.cornerRadius = 10
          return image
      }()
      
      override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        //Agregamos a la subvista el objeto y lo ubicamos
        addSubview(isAvailableLabel)
        addSubview(mapita)
        /*addSubview(namedishLabel)
        addSubview(descDishLabel)
        addSubview(priceLabel)
        addSubview(dishImage)
*/
        NSLayoutConstraint.activate([

            //Primera fila de id nombre y telefono
            isAvailableLabel.topAnchor.constraint(equalTo: topAnchor , constant: 20),
            isAvailableLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            isAvailableLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            isAvailableLabel.heightAnchor.constraint(equalToConstant: 20),
            isAvailableLabel.widthAnchor.constraint(equalToConstant: frame.width),
            
            mapita.topAnchor.constraint(equalTo: isAvailableLabel.topAnchor , constant: 20),
            mapita.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            mapita.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            mapita.heightAnchor.constraint(equalToConstant: 20),
            mapita.widthAnchor.constraint(equalToConstant: frame.width),
            /*
            namedishLabel.topAnchor.constraint(equalTo: isAvailableLabel.bottomAnchor),
            namedishLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            namedishLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            namedishLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descDishLabel.topAnchor.constraint(equalTo: namedishLabel.bottomAnchor),
            descDishLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            descDishLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            descDishLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: descDishLabel.bottomAnchor),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            priceLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            dishImage.topAnchor.constraint(equalTo: topAnchor , constant: 20),
            dishImage.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            dishImage.widthAnchor.constraint(equalToConstant: frame.width/2),
            dishImage.heightAnchor.constraint(equalToConstant: frame.width/2),
           */
        ])

      }
        
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

}
