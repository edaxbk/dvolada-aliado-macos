//
//  DirectionCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit


class DirectionCell : UICollectionViewCell {
    
    var direction : Direction? {
        didSet{
            let url = "https://maps.googleapis.com/maps/api/staticmap?center=\(direction?.coordinates?.latitude ?? 0.0 ),\(direction?.coordinates?.longitude ?? 0.0)&zoom=19&size=400x400&key=AIzaSyBEVFfED18HIbgjd3behPizz5YAZHEbXzA"

            imageDelivery.loadImageCropped(url: url)
            
            let attributedText = NSMutableAttributedString(string: "Dirección", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])

            attributedText.append(NSAttributedString(string: "\n\n\(direction?.direction! ?? "Pedido externo")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))

            descriptionTextView.attributedText = attributedText

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
    
    
    let iconCart : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = #imageLiteral(resourceName: "icons8-delivery-96")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    var deliveryText : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.backgroundColor = .white
        text.textColor = .black
        text.isSelectable = false
        text.isEditable  = false
        text.text = "Delivery"
        text.isScrollEnabled = false
        text.font = UIFont.systemFont(ofSize: 12)
        
        return text
    }()
    
    
    
    
    let grayLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()
    

    
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.sizeToFit()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageDelivery)
        addSubview(descriptionTextView)
        addSubview(grayLine)
        addSubview(iconCart)
        addSubview(deliveryText)
        
        
        NSLayoutConstraint.activate([
            
            imageDelivery.topAnchor.constraint(equalTo: topAnchor , constant: 10),
            imageDelivery.leftAnchor.constraint(equalTo: leftAnchor , constant: 30),
            imageDelivery.heightAnchor.constraint(equalToConstant: 130),
            imageDelivery.widthAnchor.constraint(equalToConstant: 130),
            
            descriptionTextView.topAnchor.constraint(equalTo: topAnchor , constant: 20),
            descriptionTextView.leftAnchor.constraint(equalTo: imageDelivery.rightAnchor , constant: 20),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            descriptionTextView.widthAnchor.constraint(equalToConstant: 200),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
            grayLine.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor , constant: 40),
            grayLine.leftAnchor.constraint(equalTo: leftAnchor , constant: 15),
            grayLine.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            grayLine.heightAnchor.constraint(equalToConstant: 1),
            
            iconCart.topAnchor.constraint(equalTo: grayLine.bottomAnchor, constant: 15),
            iconCart.leftAnchor.constraint(equalTo: leftAnchor , constant: 35),
            iconCart.heightAnchor.constraint(equalToConstant: 20),
            iconCart.widthAnchor.constraint(equalToConstant: 20),
            
            deliveryText.topAnchor.constraint(equalTo: grayLine.bottomAnchor, constant: 10),
            deliveryText.leftAnchor.constraint(equalTo: iconCart.rightAnchor , constant: 10),
            
            
            
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
