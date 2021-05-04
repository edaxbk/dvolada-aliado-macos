//
//  ItemBarContentView.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 18/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import Foundation
import ESTabBarController_swift

class ItemBarContentView : ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        highlightTextColor = .darkGray
        highlightIconColor = .darkGray
        iconColor = .white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
