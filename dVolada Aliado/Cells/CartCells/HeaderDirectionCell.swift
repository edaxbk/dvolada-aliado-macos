//
//  HeaderDirectionCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class HeaderDirectionCell : UICollectionViewCell {
    
    var direction : Direction? {
        didSet{
            let url = "https://maps.googleapis.com/maps/api/staticmap?center=\(direction!.coordinates!.latitude!),\(direction!.coordinates!.longitude!)&zoom=19&size=400x400&key=AIzaSyBEVFfED18HIbgjd3behPizz5YAZHEbXzA"
            
            imageDelivery.loadImageCropped(url: url)
            
            directionLabel.text = direction?.direction
        }
    }

    let imageDelivery : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let markerIcon : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = #imageLiteral(resourceName: "marker")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let directionTitleLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.text = "Entregar en"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.isUserInteractionEnabled = false
        label.textColor = .black

        return label
    }()
    
    let directionLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "Manrope-Light", size: 8)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = .black

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageDelivery)
        addSubview(directionTitleLabel)
        addSubview(directionLabel)
        
        NSLayoutConstraint.activate([
            
            imageDelivery.topAnchor.constraint(equalTo: topAnchor , constant: 80),
            imageDelivery.leftAnchor.constraint(equalTo: leftAnchor , constant: 30),
            imageDelivery.heightAnchor.constraint(equalToConstant: 100),
            imageDelivery.widthAnchor.constraint(equalToConstant: 100),
            
            directionTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            directionTitleLabel.leftAnchor.constraint(equalTo: imageDelivery.rightAnchor, constant: 20),
            directionTitleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            directionLabel.topAnchor.constraint(equalTo: directionTitleLabel.bottomAnchor, constant: 10),
            directionLabel.leftAnchor.constraint(equalTo: imageDelivery.rightAnchor, constant: 20),
            directionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -((frame.width / 4) - 20)),
            
        ])
        
        imageDelivery.addSubview(markerIcon)
        
        NSLayoutConstraint.activate([
            markerIcon.centerXAnchor.constraint(equalTo: imageDelivery.centerXAnchor),
            markerIcon.centerYAnchor.constraint(equalTo: imageDelivery.centerYAnchor),
            markerIcon.widthAnchor.constraint(equalToConstant: 40),
            markerIcon.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
