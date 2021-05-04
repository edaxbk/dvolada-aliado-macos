//
//  FooterDetails.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 18/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class FooterDetails: UICollectionViewCell {
    
    let orderID = "orden ID"
    var order : Order? {
        didSet {
            if(order?.status == "STORE_PENDING"){
                confirmBtn.isHidden = false
                denyBtn.isHidden = false
                timeApoxText.isHidden = false
                layoutIfNeeded()
            }
        }
    }
    
    var timeListener : TimeListener?
    
    
    let timeApoxText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.boldSystemFont(ofSize: 22)
        text.textContentType = .telephoneNumber
        text.textColor = .black
        text.isHidden  = true
        text.textAlignment = .center
        text.attributedPlaceholder = NSAttributedString(string: "Tiempo Aproximado (min)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return text
    }()
    
    let confirmBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Confirmar", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.isHidden  = true
        btn.backgroundColor = .green
        return btn
        
    }()
    
    let denyBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Rechazar", for: .normal)
        btn.layer.cornerRadius = 5
        btn.isHidden  = true
        btn.backgroundColor = .red
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(timeApoxText)
        addSubview(confirmBtn)
        addSubview(denyBtn)
        
        timeApoxText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        
        NSLayoutConstraint.activate([
            
            timeApoxText.topAnchor.constraint(equalTo: topAnchor , constant: 20),
            timeApoxText.leftAnchor.constraint(equalTo: leftAnchor ,constant:  25),
            timeApoxText.heightAnchor.constraint(equalToConstant: 60),
            
            denyBtn.topAnchor.constraint(equalTo: timeApoxText.bottomAnchor , constant: 30),
            denyBtn.leftAnchor.constraint(equalTo: leftAnchor ,constant: 20),
            
            denyBtn.heightAnchor.constraint(equalToConstant: 40),
            denyBtn.widthAnchor.constraint(equalToConstant: frame.width/2.5),
            
            confirmBtn.topAnchor.constraint(equalTo: timeApoxText.bottomAnchor , constant: 30),
            
            confirmBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant: 40),
            confirmBtn.widthAnchor.constraint(equalToConstant: frame.width/2.5),
        ])
        
        
        confirmBtn.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        
        
        
    }
    
    @objc func textFieldDidChange() {
        timeListener?.onTimeListener(timeEstimate: timeApoxText.text!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
