//
//  DishHeaderCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import Foundation
import UIKit

class DishHeaderCell: UICollectionViewCell {
    
    var dish : Dish? {
        didSet {
            if let images = dish?.images, !(dish?.images?.isEmpty ?? false) {
                let url = images[0]
                bgImage.loadImageCropped(url: url)
            }
            
            storeName.text = dish?.title
        }
    }
    
    
    var blackContainer : UIView = {
        
        let black = UIView()
        black.translatesAutoresizingMaskIntoConstraints = false
        black.alpha = 0.6
        black.backgroundColor = .black
        
        return black
    }()
    
    var bgImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .orange
        image.clipsToBounds = true
        return image
    }()
    
    var storeName : UITextView = {
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 22)
        
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        

        
        addSubview(bgImage)
        addSubview(blackContainer)
        addSubview(storeName)
        
        
        NSLayoutConstraint.activate([
            
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.leftAnchor.constraint(equalTo: leftAnchor),
            bgImage.rightAnchor.constraint(equalTo: rightAnchor),
            bgImage.heightAnchor.constraint(equalToConstant: 260),
            
            
            storeName.leftAnchor.constraint(equalTo: leftAnchor , constant: 22),
            storeName.rightAnchor.constraint(equalTo: rightAnchor , constant: -10),
            storeName.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor , constant: -20),
            
            
            blackContainer.topAnchor.constraint(equalTo: topAnchor),
            blackContainer.leftAnchor.constraint(equalTo: leftAnchor),
            blackContainer.rightAnchor.constraint(equalTo: rightAnchor),
            blackContainer.heightAnchor.constraint(equalToConstant: 260),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
