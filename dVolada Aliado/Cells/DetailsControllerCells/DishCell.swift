//
//  DishCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 19/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class DishCell: UICollectionViewCell {
    
    var ordenID = "ordenid"
    
    var cart : Cart? {
        didSet{
            quantityLabel.text = String(cart!.quantity!)
            namedishLabel.text = cart?.dish?.title
            totalLabel.text = "$\(cart!.quantity! * (cart!.dish?.price)!).00"
        }
    }
    
    let quantityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let namedishLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = .black
        return label
    }()
    
    let totalLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(quantityLabel)
        addSubview(namedishLabel)
        addSubview(totalLabel)
        
        
      
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
