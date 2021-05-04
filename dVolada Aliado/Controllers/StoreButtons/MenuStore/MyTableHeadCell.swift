//
//  MyHeadCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class MyTableHeadCell: UITableViewCell {
    
    
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
        return label
    }()
    
    var switchAvailable : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.contentVerticalAlignment = .center
        return sw
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(nameMenuLabel)
        addSubview(switchAvailable)
        
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            nameMenuLabel.topAnchor.constraint(equalTo: topAnchor),
            nameMenuLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            nameMenuLabel.widthAnchor.constraint(equalToConstant: frame.width),
            nameMenuLabel.heightAnchor.constraint(equalToConstant: frame.height),
            
            switchAvailable.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            switchAvailable.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            switchAvailable.centerYAnchor.constraint(equalTo: centerYAnchor)
            
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



