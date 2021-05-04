//
//  HeaderDetails.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 18/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class HeaderDetails: UICollectionViewCell {
    
    let orderID = "orden ID"
    
    var order : Order? {
        didSet{
            
            idLabelR.text =  String((order?._id?.prefix(6))!)
            nameLabel.text = order?.client?.complete_name
            phoneLabel.text = order?.client?.phone_number
            
          
            if let dt = order?.date_mobile{
                dateLabel.text = "Fecha del pedido: \(dt)"
                print(dt)
            }
            
            if let st = order?.paymentCharge{
                subTotalLabel.text = "Subtotal: $\(Int(st.subTotal!.rounded())).00"
            }
            
        }
    }
    
    let idLabelR : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "12345|"
        label.font = label.font.withSize(12)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textAlignment = .left
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let phoneLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+522461888475"
        label.textAlignment = .left
        label.font = label.font.withSize(12)
        label.textColor = .black
        return label
    }()
    
    let payLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(18)
        label.text = "Efectivo"
        label.textColor = .black
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.text = "Fecha del pedido"
        label.textColor = .black
        
        
        return label
    }()
    
    let subTotalLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = .black
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(idLabelR)
        addSubview(nameLabel)
        addSubview(phoneLabel)
        addSubview(payLabel)
        addSubview(dateLabel)
        addSubview(subTotalLabel)
        
        
        
        switch UIDevice.current.userInterfaceIdiom {
         case .phone:
             // It's an iPhone
            NSLayoutConstraint.activate([
                
                idLabelR.topAnchor.constraint(equalTo: topAnchor , constant: 20),
                idLabelR.leftAnchor.constraint(equalTo: leftAnchor,constant: 20 ),
                idLabelR.heightAnchor.constraint(equalToConstant: 60),
                idLabelR.widthAnchor.constraint(equalToConstant: (frame.width/10)*1.5 ),
                
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                nameLabel.leftAnchor.constraint(equalTo: idLabelR.rightAnchor),
                nameLabel.heightAnchor.constraint(equalToConstant: 60),
                nameLabel.widthAnchor.constraint(equalToConstant: (frame.width/10)*4.5),
                
                phoneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                phoneLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
                phoneLabel.heightAnchor.constraint(equalToConstant: 60),
                phoneLabel.widthAnchor.constraint(equalToConstant: 130),
                
                payLabel.topAnchor.constraint(equalTo: idLabelR.bottomAnchor , constant: 1),
                payLabel.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
                payLabel.rightAnchor.constraint(equalTo: rightAnchor),
                payLabel.heightAnchor.constraint(equalToConstant: 30),
                        
                dateLabel.topAnchor.constraint(equalTo: payLabel.bottomAnchor , constant: 1),
                dateLabel.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
                dateLabel.rightAnchor.constraint(equalTo: rightAnchor),
                dateLabel.heightAnchor.constraint(equalToConstant: 40),
                            
                subTotalLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor , constant: 1),
                subTotalLabel.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
                subTotalLabel.rightAnchor.constraint(equalTo: rightAnchor),
                subTotalLabel.heightAnchor.constraint(equalToConstant: 20),
                
            ])
         case .pad:
             // It's an iPad (or macOS Catalyst)
            NSLayoutConstraint.activate([
                
                idLabelR.topAnchor.constraint(equalTo: topAnchor , constant: 20),
                idLabelR.leftAnchor.constraint(equalTo: leftAnchor,constant: 20 ),
                idLabelR.heightAnchor.constraint(equalToConstant: 60),
                idLabelR.widthAnchor.constraint(equalToConstant: (frame.width/10)*1.5 ),
                
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                nameLabel.leftAnchor.constraint(equalTo: idLabelR.rightAnchor),
                nameLabel.heightAnchor.constraint(equalToConstant: 60),
                nameLabel.widthAnchor.constraint(equalToConstant: (frame.width/10)*4.5),
                
                phoneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                phoneLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40 ),
                phoneLabel.heightAnchor.constraint(equalToConstant: 60),
                phoneLabel.widthAnchor.constraint(equalToConstant: 200),
                
                payLabel.topAnchor.constraint(equalTo: idLabelR.bottomAnchor , constant: 1),
                payLabel.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
                payLabel.rightAnchor.constraint(equalTo: rightAnchor),
                payLabel.heightAnchor.constraint(equalToConstant: 30),
                        
                dateLabel.topAnchor.constraint(equalTo: payLabel.bottomAnchor , constant: 1),
                dateLabel.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
                dateLabel.rightAnchor.constraint(equalTo: rightAnchor),
                dateLabel.heightAnchor.constraint(equalToConstant: 40),
                            
                subTotalLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor , constant: 1),
                subTotalLabel.leftAnchor.constraint(equalTo: leftAnchor , constant: 20),
                subTotalLabel.rightAnchor.constraint(equalTo: rightAnchor),
                subTotalLabel.heightAnchor.constraint(equalToConstant: 20),
                
            ])
         case .unspecified:
             // Uh, oh! What could it be?
            break
        case .tv:
            break
        case .carPlay:
            break
        case .mac:
            break
        @unknown default:
            break
        }
        
        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

