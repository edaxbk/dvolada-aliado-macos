//
//  AddNewMenuCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class AddNewMenuCell: UICollectionViewCell {
        
   

    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Crea tu menu"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
    return label
    }()
    
    let nameMenuText : UITextField = {
           let text = UITextField()
           text.translatesAutoresizingMaskIntoConstraints = false
           text.font = UIFont.boldSystemFont(ofSize: 20)
           text.placeholder = ("Nombre del menu")
       return text
       }()
    
    //Lineas Grises
    let lineBottonH: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
    return label
    }()
  
    let confirmBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitle("Guardar", for: .normal)
        btn.tintColor = .white
    return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(titleLabel)

        addSubview(nameMenuText)
        addSubview(lineBottonH)
        addSubview(confirmBtn)
    
          NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
    
            nameMenuText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 40),
            nameMenuText.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            nameMenuText.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nameMenuText.heightAnchor.constraint(equalToConstant: 40),
            
            lineBottonH.bottomAnchor.constraint(equalTo:nameMenuText.bottomAnchor),
            lineBottonH.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            lineBottonH.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            lineBottonH.heightAnchor.constraint(equalToConstant: 1),
                       
            confirmBtn.topAnchor.constraint(equalTo: lineBottonH.bottomAnchor,constant: 50),
            confirmBtn.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            confirmBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant: frame.height / 12),
           
          ])
      
        }
    
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }



