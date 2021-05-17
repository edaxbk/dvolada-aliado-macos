//
//  EmptyCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit


class EmptyCell : UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
