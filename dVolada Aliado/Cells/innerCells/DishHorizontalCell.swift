//
//  DishHorizontalCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit


class DishHorizontalCell: UICollectionViewCell {
    
    static let placeHolderImage = #imageLiteral(resourceName: "mercado")
    
    
    var shouldHideButton : Bool? {
        didSet {
            addButton.isHidden = shouldHideButton!
        }
    }
    
    var dish : Dish? {
        didSet {
            
            if let images = dish?.images , !images.isEmpty{
                dishImageView.loadImageCropped(url: images[0])
            }else{
                dishImageView.image = DishHorizontalCell.placeHolderImage

            }

            titleDishLabel.text = dish?.title
            priceLabel.text = "$\(dish!.price!).00"
            
            
            
            if let description = dish?.description {
                if(description.count > 80){
                    let desriptionFormated = description.split(by: 80)
                    descriptionDishLabel.text = "\(desriptionFormated.joined())..."
                }else{
                    descriptionDishLabel.text = description
                }
            }
            
            
        }
    }
    
    
    let dishImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.image = placeHolderImage
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.backgroundColor = .orange
        image.isUserInteractionEnabled = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    
    let titleDishLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Nombre del platillo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        
        return label
    }()
    
    
    
    let descriptionDishLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .darkGray
        label.numberOfLines = 4
        label.sizeToFit()
        
        return label
    }()
    
    
    let priceLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$4.99"
        label.font = UIFont(name: "Manrope-Light", size: 10)
        label.textColor = UIColor(red: 0.88, green: 0.28, blue: 0.16, alpha: 1.00)
        label.isUserInteractionEnabled = false
        label.sizeToFit()
        
        return label
    }()
    
    
    let addButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Agregar", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(dishImageView)
        addSubview(titleDishLabel)
        addSubview(priceLabel)
        addSubview(descriptionDishLabel)
        addSubview(addButton)
        
        
        NSLayoutConstraint.activate([
            
            dishImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3),
            dishImageView.leftAnchor.constraint(equalTo: leftAnchor),
            dishImageView.widthAnchor.constraint(equalToConstant: 80),
            dishImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleDishLabel.centerYAnchor.constraint(equalTo: centerYAnchor , constant: -25),
            titleDishLabel.leftAnchor.constraint(equalTo: dishImageView.rightAnchor , constant: 10),
            titleDishLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            
            descriptionDishLabel.topAnchor.constraint(equalTo: titleDishLabel.bottomAnchor),
            descriptionDishLabel.leftAnchor.constraint(equalTo: dishImageView.rightAnchor , constant: 10),
            descriptionDishLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
    
            priceLabel.topAnchor.constraint(equalTo: descriptionDishLabel.bottomAnchor , constant: 3),
            priceLabel.leftAnchor.constraint(equalTo: dishImageView.rightAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            addButton.topAnchor.constraint(equalTo: descriptionDishLabel.bottomAnchor , constant: 3),
            addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            addButton.widthAnchor.constraint(equalToConstant: 70),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
        addButton.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension String {
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
}
