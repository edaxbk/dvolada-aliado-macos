//
//  HeaderLoginCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 23/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit


class LoginCell: UICollectionViewCell {
        
    var logo : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.layer.cornerRadius = 50
        
        return image
    }()

    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "dVolada Aliado"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.textColor = .black
    return label
    }()
    
    let emailTextField : UITextField = {
           let text = UITextField()
           text.translatesAutoresizingMaskIntoConstraints = false
           text.font = UIFont.boldSystemFont(ofSize: 20)
           text.placeholder = (" Email")
          
       return text
       }()
           
    let passwordTextField : UITextField = {
           let text = UITextField()
           text.translatesAutoresizingMaskIntoConstraints = false
           text.font = UIFont.boldSystemFont(ofSize: 20)
           text.placeholder = (" Password")
    
        text.isSecureTextEntry = true
       return text
       }()
           
    let initSessionBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        btn.imageEdgeInsets.left = -100
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitle("Iniciar Session", for: .normal)
        btn.tintColor = .white
    return btn
    }()
    
    
    //Lineas Grises
    let lineBottonH: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
    return label
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)

     
        addSubview(logo)
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(lineBottonH)
        addSubview(passwordTextField)
        addSubview(initSessionBtn)
    
          NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: topAnchor,constant: frame.height/8),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: frame.height/4),
            logo.heightAnchor.constraint(equalToConstant: frame.height / 4),
    
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.widthAnchor.constraint(equalToConstant: frame.width / 2),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lineBottonH.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 2.5),
                    lineBottonH.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
                    lineBottonH.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
                    lineBottonH.heightAnchor.constraint(equalToConstant: 1),
                                      
           
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 5),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo:rightAnchor,constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

       
                       
            initSessionBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20),
            initSessionBtn.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            initSessionBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            initSessionBtn.heightAnchor.constraint(equalToConstant: frame.height / 12),
           
          ])
      
        }
    
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }



