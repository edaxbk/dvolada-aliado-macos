//
//  DishMenuStoreHeadCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 29/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class DishMenuStoreHeadView: UIView {
    
    var menu : Menu? {
        didSet{
            nameMenuLabel.text = menu?.title
            switchAvailable.setOn(menu?.isAvailable ?? false, animated: true)
        }
    }
    
    let nameMenuLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(25)
        label.text = "Nombre Categoria"
        label.textAlignment = .left
        label.backgroundColor =  .clear
        return label
    }()
    
    var switchAvailable : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
         return sw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(nameMenuLabel)
        addSubview(switchAvailable)
        
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            nameMenuLabel.topAnchor.constraint(equalTo: topAnchor),
            nameMenuLabel.leftAnchor.constraint(equalTo: leftAnchor),
            nameMenuLabel.heightAnchor.constraint(equalTo: heightAnchor),
            nameMenuLabel.widthAnchor.constraint(equalTo: widthAnchor),
            
            switchAvailable.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            switchAvailable.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        switchAvailable.addTarget(self, action: #selector(valueChange), for: .valueChanged)
    }
    
    
    @objc func valueChange(_sender : UISwitch) {
        ServerHelper.shared.putMenuFromStore(id: (menu?._id)! , isAvailable: _sender.isOn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



