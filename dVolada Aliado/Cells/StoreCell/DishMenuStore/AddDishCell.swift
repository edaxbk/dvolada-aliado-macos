//
//  AddDishCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class AddDishCell: UICollectionViewCell {
        
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Crea tu platillo"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
       
    var addDishImg : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()

   
    let nameDishText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(15)
        text.placeholder = ("Nombre del producto")
   return text
   }()
       
    let descDishText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(15)
        text.placeholder = (" Descripción del producto")
    return text
    }()

    let priceDishText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(15)
        text.placeholder = ("Precio")
    return text
    }()
    
    let modificadorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Modificador"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
    return label
    }()
           
    let modificadorBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.setTitle("Agregar Modificador", for: .normal)
        btn.backgroundColor = .red
    return btn
    }()
    
    let confirmBtn : UIButton = {
          let btn = UIButton()
          btn.backgroundColor = .lightGray
          btn.translatesAutoresizingMaskIntoConstraints = false
          btn.layer.cornerRadius = 10
          btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
          btn.setTitle("GUARDAR", for: .normal)
      return btn
      }()
    
    //Lineas Grises
    let lineBottonH: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
    return label
    }()
    
    let lineBottonH2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
    return label
    }()
    
    let lineBottonH3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
    return label
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(addDishImg)
        addSubview(nameDishText)
            addSubview(lineBottonH)
        addSubview(descDishText)
            addSubview(lineBottonH2)
        addSubview(priceDishText)
            addSubview(lineBottonH3)
        addSubview(modificadorLabel)
        addSubview(modificadorBtn)
        addSubview(confirmBtn)
        
    
          NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
    
            addDishImg.centerXAnchor.constraint(equalTo: centerXAnchor),
            addDishImg.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            addDishImg.heightAnchor.constraint(equalToConstant: frame.width/3),
            addDishImg.widthAnchor.constraint(equalToConstant: frame.width/3),
            
            nameDishText.topAnchor.constraint(equalTo: addDishImg.bottomAnchor,constant: 20),
            nameDishText.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            nameDishText.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            nameDishText.heightAnchor.constraint(equalToConstant: 50),
                
                lineBottonH.bottomAnchor.constraint(equalTo: nameDishText.bottomAnchor,constant: -10),
                lineBottonH.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
                lineBottonH.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                lineBottonH.heightAnchor.constraint(equalToConstant: 0.5),
            
            descDishText.topAnchor.constraint(equalTo: nameDishText.bottomAnchor,constant: 20),
            descDishText.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            descDishText.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            descDishText.heightAnchor.constraint(equalToConstant: 50),
            
                lineBottonH2.bottomAnchor.constraint(equalTo: descDishText.bottomAnchor,constant: -10),
                lineBottonH2.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
                lineBottonH2.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                lineBottonH2.heightAnchor.constraint(equalToConstant: 0.5),
            
            priceDishText.topAnchor.constraint(equalTo: descDishText.bottomAnchor,constant: 20),
            priceDishText.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            priceDishText.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            priceDishText.heightAnchor.constraint(equalToConstant: 50),

                lineBottonH3.bottomAnchor.constraint(equalTo: priceDishText.bottomAnchor,constant: -10),
                lineBottonH3.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
                lineBottonH3.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
                lineBottonH3.heightAnchor.constraint(equalToConstant: 0.5),
             
            
            modificadorLabel.topAnchor.constraint(equalTo: priceDishText.bottomAnchor,constant: 20),
            modificadorLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            modificadorLabel.widthAnchor.constraint(equalToConstant: frame.width / 3),
            modificadorLabel.heightAnchor.constraint(equalToConstant: 50),
            
            modificadorBtn.topAnchor.constraint(equalTo: priceDishText.bottomAnchor,constant: 20),
            modificadorBtn.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            modificadorBtn.widthAnchor.constraint(equalToConstant: frame.width / 2),
            modificadorBtn.heightAnchor.constraint(equalToConstant: 50),
            
            confirmBtn.topAnchor.constraint(equalTo: modificadorLabel.bottomAnchor,constant: 40),
            confirmBtn.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            confirmBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant: 50),

          ])
      
        }
    
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }



