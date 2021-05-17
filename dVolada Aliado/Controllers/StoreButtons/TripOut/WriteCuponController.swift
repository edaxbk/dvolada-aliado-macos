//
//  WriteCuponController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class WriteCuponController: UIViewController {
    
    
    var gradientContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.masksToBounds = true
        return view
    }()
    
    var exitButton : UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "icons8-back-64")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return button
    }()
    
    let titleLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Cupones"
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    let titleObservation : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Ingresa tu cupon"
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = UIColor(red: 0.10, green: 0.18, blue: 0.31, alpha: 1.00)
        
        return label
    }()
    
    
    let inputObservation : UITextField = {
        let inputModel = UITextField()
        inputModel.translatesAutoresizingMaskIntoConstraints = false
        inputModel.placeholder = "Codigo..."
        inputModel.keyboardType = .default
        inputModel.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 1.00, alpha: 1.00)
        inputModel.layer.cornerRadius = 10
        inputModel.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 20);
        return inputModel
    }()
    
    
    let addObservationButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Agregar cupon", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleAddObservation), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc func handleExit() {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(gradientContainer)
        view.addSubview(exitButton)
        
        
        NSLayoutConstraint.activate([
            
            gradientContainer.topAnchor.constraint(equalTo: view.topAnchor , constant: 0),
            gradientContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            gradientContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            gradientContainer.heightAnchor.constraint(equalToConstant: 150),
            
            
            exitButton.topAnchor.constraint(equalTo: view.topAnchor , constant: 20),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 80),
            exitButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    
        gradientContainer.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        gradientContainer.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            
            titleLabel.leftAnchor.constraint(equalTo: gradientContainer.leftAnchor, constant: 25),
            titleLabel.rightAnchor.constraint(equalTo: gradientContainer.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: gradientContainer.bottomAnchor , constant: -20),
            
           
        ])
        
        
        view.addSubview(titleObservation)
        view.addSubview(inputObservation)
        view.addSubview(addObservationButton)
        
        NSLayoutConstraint.activate([
            
            titleObservation.topAnchor.constraint(equalTo: gradientContainer.bottomAnchor, constant: 20),
            titleObservation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            inputObservation.topAnchor.constraint(equalTo: titleObservation.bottomAnchor, constant: 20),
            inputObservation.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            inputObservation.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            inputObservation.heightAnchor.constraint(equalToConstant: 50),
            
            
            addObservationButton.topAnchor.constraint(equalTo: inputObservation.bottomAnchor , constant: 20),
            addObservationButton.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            addObservationButton.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -20),
            addObservationButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        
        addObservationButton.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        
    }

    @objc func handleAddObservation(){
        
        let code = inputObservation.text
        
        if(!code!.isEmpty){
            navigationController?.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }else{
            inputObservation.shake()
        }
    }
    
    
}
