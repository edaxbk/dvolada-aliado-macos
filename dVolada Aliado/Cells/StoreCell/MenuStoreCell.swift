//
//  MenuStoreCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 28/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class MenuStoreCell: UITableViewCell {
    
    var menu : Menu? {
        didSet{
            nameMenuLabel.text = menu?.title
            if (menu?.isAvailable) == true{
                isAvailableLabel.text = "Activado"
            }else{
                isAvailableLabel.text = "Desactivado"
            }
        }
    }
    
    let nameMenuLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Nombre del Menu"
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let isAvailableLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        label.text = "Estado"
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.primaryColor
        selectionStyle = .none
        
        addSubview(nameMenuLabel)
        addSubview(isAvailableLabel)
        
        NSLayoutConstraint.activate([
            nameMenuLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameMenuLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            nameMenuLabel.heightAnchor.constraint(equalTo: heightAnchor),
            nameMenuLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            
            isAvailableLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            isAvailableLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            isAvailableLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            isAvailableLabel.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



