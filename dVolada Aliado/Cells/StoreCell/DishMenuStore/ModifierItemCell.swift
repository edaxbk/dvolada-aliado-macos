//
//  DishItemCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 17/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
//
import UIKit

class ModifierItemCell : UITableViewCell {
    
    
    var optionItem : Options? {
        didSet{
            if let name = optionItem?.name {
                titleLabel.text = name
            }
            if let price = optionItem?.fee {
                priceLabel.text = "$ " + String(price) + ".00"
            }
        }
    }
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$00.00"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor ),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.heightAnchor.constraint(equalToConstant: 50),

          ])
          
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
