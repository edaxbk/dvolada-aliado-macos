//
//  MyCustomCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 11/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class MyCustomCell : UITableViewCell {
    
    let label : UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .yellow
        
        addSubview(label)
        
        label.backgroundColor = .yellow
        label.text = "Hello Wortld "
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor),
            //label.widthAnchor.constraint(equalTo: topAnchor),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
