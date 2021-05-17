//
//  QuantityCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit

class QuantityCell: UICollectionViewCell , UITextFieldDelegate{
    
    var listener : InputListener?
        
    var quantity = 1 {
        didSet {
            quantityText.text = "\(quantity)"
        }
    }
    
    
    var grayContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.00)
        return view
    }()
    
    
    var addButton : UIButton = {
        let addButton = UIButton(type : .system)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 25
        addButton.setTitleColor(.black, for: .normal)
        addButton.layer.borderWidth = 0.2
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.isUserInteractionEnabled = true
        addButton.isEnabled = true
        return addButton
    }()
    
    var restButton : UIButton = {
        let addButton = UIButton(type : .system)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitleColor(.black, for: .normal)
        addButton.setTitle("-", for: .normal)
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 25
        addButton.layer.borderWidth = 0.2
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.isEnabled = true
        addButton.isUserInteractionEnabled = true
        return addButton
    }()
    
    var quantityText : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.text = "1"
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .center
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 14)
        return text
    }()
    
    var textBlack : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.sizeToFit()
        text.isScrollEnabled = false
        text.backgroundColor = .clear
        text.text = "Observaciones adicionales"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        return text
    }()
    
    
    let observationInput : UITextField = {
        
        let text = UITextField()
       
        text.layer.masksToBounds = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Agregar una observación"
        text.backgroundColor = .white
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        
        return text
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .white
        
        isUserInteractionEnabled = true
        self.contentView.isUserInteractionEnabled = true
        
        observationInput.delegate = self

        
        addSubview(grayContainer)
        
        NSLayoutConstraint.activate([
            grayContainer.topAnchor.constraint(equalTo: topAnchor),
            grayContainer.leftAnchor.constraint(equalTo: leftAnchor),
            grayContainer.rightAnchor.constraint(equalTo: rightAnchor),
            grayContainer.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        grayContainer.addSubview(textBlack)
        
        NSLayoutConstraint.activate([
            textBlack.topAnchor.constraint(equalTo: grayContainer.topAnchor , constant: 15),
            textBlack.leftAnchor.constraint(equalTo: grayContainer.leftAnchor , constant: 20),
            textBlack.rightAnchor.constraint(equalTo: grayContainer.rightAnchor , constant: -20)
        ])
        
        addSubview(observationInput)
        
        
        NSLayoutConstraint.activate([
            observationInput.topAnchor.constraint(equalTo: grayContainer.bottomAnchor , constant: 10),
            observationInput.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
            observationInput.rightAnchor.constraint(equalTo: rightAnchor , constant: -20),
            observationInput.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        observationInput.setBottomBorder()
        
        
        
        
        addSubview(quantityText)
        addSubview(addButton)
        addSubview(restButton)
        
        NSLayoutConstraint.activate([
            
            quantityText.topAnchor.constraint(equalTo: observationInput.bottomAnchor, constant: 40),
            quantityText.centerXAnchor.constraint(equalTo: centerXAnchor),
            quantityText.widthAnchor.constraint(equalToConstant: 30),
            
            addButton.topAnchor.constraint(equalTo: observationInput.bottomAnchor , constant: 30),
            addButton.leftAnchor.constraint(equalTo: quantityText.rightAnchor , constant: 20),
            addButton.widthAnchor.constraint(equalToConstant: 50),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            restButton.topAnchor.constraint(equalTo: observationInput.bottomAnchor , constant: 30),
            restButton.rightAnchor.constraint(equalTo: quantityText.leftAnchor , constant: -20),
            restButton.widthAnchor.constraint(equalToConstant: 50),
            restButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = observationInput.text
        listener?.onEditTextChanged(text: text!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

extension UITextField {
  func setBottomBorder() {
    self.borderStyle = .none
    self.layer.backgroundColor = UIColor.white.cgColor

    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 1.0
    self.layer.shadowRadius = 0.0
  }
}

