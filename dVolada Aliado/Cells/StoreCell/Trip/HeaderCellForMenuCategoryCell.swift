//
//  HeaderCellForMenuCategoryCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

class SupView: UICollectionReusableView {
    
    let namedishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Title"
        label.textAlignment = .left
    return label
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        backgroundColor = .orange
        
        addSubview(namedishLabel)
        
        NSLayoutConstraint.activate([
        
            namedishLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
            namedishLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            namedishLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -100),
            namedishLabel.heightAnchor.constraint(equalTo: heightAnchor),
        ])
                                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been® implemented")
    }
}
