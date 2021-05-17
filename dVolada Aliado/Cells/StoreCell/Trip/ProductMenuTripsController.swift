//
//  ProductMenuTripsController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class ProductMenuTripsController : UIViewController{
    
    
    var dishes : Dish? {
        didSet{
            
      
            if let urlImage = dishes?.images?.first{
                bgImage.loadImage(url: urlImage)
            }
            if let title = dishes?.title{
                nameLabel.text = title
            }
            if let desc = dishes?.description {
                descLabel.text = desc
            }
            if let price = dishes?.price {
                costo = Float(price)
            }
            
        }
    }
    
    
    var contador = 1
    var costo : Float = 0.00
    var total: Float = 0.00
    
    var bgImage : UIImageView = {
          let image = UIImageView()
          image.image = UIImage(named: "logo")
          image.translatesAutoresizingMaskIntoConstraints = false
          image.layer.masksToBounds = false
          image.contentMode = .scaleAspectFill
          image.backgroundColor = .black
          image.clipsToBounds = true
          return image
      }()
    
    var blackView : UIView = {
        let vista = UIView()
        vista.translatesAutoresizingMaskIntoConstraints = false
        vista.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return vista
    }()
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nombre del prducto"
        label.font = label.font.withSize(30)
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .clear
    return label
    }()
    
    let descLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Descripcion del prducto"
        label.font = label.font.withSize(12)
        label.textAlignment = .left
    return label
    }()
    
    let obsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "   Observaciones adicionales"
        label.font = label.font.withSize(18)
        label.textAlignment = .left
        label.backgroundColor = #colorLiteral(red: 0.9279266516, green: 0.9279266516, blue: 0.9279266516, alpha: 1)
    return label
    }()
    
    let addNoteTextField : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.boldSystemFont(ofSize: 12)
        text.placeholder = ("Agregar nota")
        return text
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MX$195.00"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    
    let addCartBtn : UIButton = {
        
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(15)
        btn.setTitle("Agregar 1 al carrito", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = #colorLiteral(red: 0.009940003735, green: 0.7379371762, blue: 0.05223868774, alpha: 1)
        btn.tintColor = .white
        return btn
    }()
    
    let numberLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(18)
        label.textAlignment = .center
    return label
    }()
    
    let addBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 25
        btn.setImage(UIImage(systemName: "plus"), for: .normal )
        btn.contentVerticalAlignment = .center
        btn.contentHorizontalAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.layer.borderWidth = 1
        //btn.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        btn.tintColor = .black
        return btn
    }()
    
    let sustracBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 25
        btn.setImage(UIImage(systemName: "minus"), for: .normal)
        btn.contentVerticalAlignment = .center
        btn.contentHorizontalAlignment = .center
        btn.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btn.layer.borderWidth = 1
        //btn.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        btn.tintColor = .black
        return btn
    }()
    
    let lineBottonH: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        total = Float(contador) * costo
        
        numberLabel.text = String(contador)
        addCartBtn.setTitle("Agregar \(contador) al carrito", for: .normal)
        totalLabel.text = "MX$\(String(format: "%.2f",total))"
        
       
        view.backgroundColor = .white
        
        view.addSubview(bgImage)
        view.addSubview(blackView)
        view.addSubview(nameLabel)
        view.addSubview(descLabel)
        view.addSubview(obsLabel)
        view.addSubview(addNoteTextField)
        view.addSubview(lineBottonH)
        view.addSubview(numberLabel)
        view.addSubview(addBtn)
        view.addSubview(sustracBtn)
        view.addSubview(addCartBtn)
        addCartBtn.addSubview(totalLabel)
        
        NSLayoutConstraint.activate([
            
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            bgImage.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            
            blackView.topAnchor.constraint(equalTo: view.topAnchor),
            blackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blackView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            
                nameLabel.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor),
                nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -20),
                nameLabel.heightAnchor.constraint(equalToConstant: 50 ),
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descLabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor),
            descLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            descLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            descLabel.heightAnchor.constraint(equalToConstant: 80),
            
            
            obsLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor),
            obsLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            obsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            addNoteTextField.topAnchor.constraint(equalTo: obsLabel.bottomAnchor),
            addNoteTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            addNoteTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            addNoteTextField.heightAnchor.constraint(equalToConstant: 40),
                
                    lineBottonH.bottomAnchor.constraint(equalTo: addNoteTextField.bottomAnchor,constant: 2.5),
                    lineBottonH.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
                    lineBottonH.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
                    lineBottonH.heightAnchor.constraint(equalToConstant: 1),
            
            numberLabel.topAnchor.constraint(equalTo: addNoteTextField.bottomAnchor,constant: 50),
            numberLabel.widthAnchor.constraint(equalToConstant: 80),
            numberLabel.heightAnchor.constraint(equalToConstant: 50),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            sustracBtn.topAnchor.constraint(equalTo: addNoteTextField.bottomAnchor,constant: 50),
            sustracBtn.widthAnchor.constraint(equalToConstant: 50),
            sustracBtn.heightAnchor.constraint(equalToConstant: 50),
            sustracBtn.rightAnchor.constraint(equalTo: numberLabel.leftAnchor,constant: -10),
            
            addBtn.topAnchor.constraint(equalTo: addNoteTextField.bottomAnchor,constant: 50),
            addBtn.widthAnchor.constraint(equalToConstant: 50),
            addBtn.heightAnchor.constraint(equalToConstant: 50),
            addBtn.leftAnchor.constraint(equalTo: numberLabel.rightAnchor,constant: 10),
            
            addCartBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addCartBtn.widthAnchor.constraint(equalTo: view.widthAnchor),
            addCartBtn.heightAnchor.constraint(equalToConstant: 80),
            
            totalLabel.centerYAnchor.constraint(equalTo: addCartBtn.centerYAnchor),
            totalLabel.rightAnchor.constraint(equalTo: addCartBtn.rightAnchor,constant: -20),
            
        ])
        
        addBtn.addTarget(self, action: #selector(addNum(_sender:)), for: .touchUpInside)
        sustracBtn.addTarget(self, action: #selector(susNum(_sender:)), for: .touchUpInside)
        addCartBtn.addTarget(self, action: #selector(addProduct(_sender:)), for: .touchUpInside)
    }
    
    @objc func addNum(_sender: UIButton) {
        contador+=1
        total = Float(contador) * costo
        numberLabel.text = String(contador)
        addCartBtn.setTitle("Agregar \(contador) al carrito", for: .normal)
        totalLabel.text = "MX$\(String(format: "%.2f",total))"
    }
    @objc func susNum(_sender: UIButton) {
        if contador>1{
            contador-=1
        }else{
            contador=1
        }
        total = Float(contador) * costo
        numberLabel.text = String(contador)
        addCartBtn.setTitle("Agregar \(contador) al carrito", for: .normal)
        totalLabel.text = "MX$\(String(format: "%.2f",total))"
    }
    
    @objc func addProduct(_sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

