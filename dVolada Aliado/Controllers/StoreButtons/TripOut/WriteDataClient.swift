//
//  WriteDataClient.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import SCLAlertView

class WriteDataClient: UIViewController {
    
    var listener : ClientDataListener?

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
        label.text = "Agregar informacion del cliente"
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    
    let clientText : UITextField = {
        let inputModel = UITextField()
        inputModel.translatesAutoresizingMaskIntoConstraints = false
        inputModel.placeholder = "Nombre del cliente"
        inputModel.keyboardType = .default
        inputModel.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 1.00, alpha: 1.00)
        inputModel.layer.cornerRadius = 10
        inputModel.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 20);
        return inputModel
    }()
    
    let phoneComplementLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "+ 52"
        label.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 1.00, alpha: 1.00)
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = .black
        return label
    }()
    
    let phoneNumberText : UITextField = {
        let inputModel = UITextField()
        inputModel.translatesAutoresizingMaskIntoConstraints = false
        inputModel.placeholder = "Numero telefonico"
        inputModel.keyboardType = .numberPad
        inputModel.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 1.00, alpha: 1.00)
        inputModel.layer.cornerRadius = 10
        inputModel.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 20);
        return inputModel
    }()
    
    
    
    let addClientDataButton : UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Agregar datos del cliente", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleAddClientData), for: .touchUpInside)
        
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
        
        
        view.addSubview(clientText)
        view.addSubview(phoneComplementLabel)
        view.addSubview(phoneNumberText)
        view.addSubview(addClientDataButton)

        NSLayoutConstraint.activate([
            
            clientText.topAnchor.constraint(equalTo: gradientContainer.bottomAnchor, constant: 20),
            clientText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            clientText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            clientText.heightAnchor.constraint(equalToConstant: 50),
            
            phoneComplementLabel.topAnchor.constraint(equalTo: clientText.bottomAnchor, constant: 20),
            phoneComplementLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            phoneComplementLabel.widthAnchor.constraint(equalToConstant: 50),
            phoneComplementLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
            phoneNumberText.topAnchor.constraint(equalTo: clientText.bottomAnchor, constant: 20),
            phoneNumberText.leftAnchor.constraint(equalTo: phoneComplementLabel.rightAnchor, constant: 40),
            phoneNumberText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            phoneNumberText.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            addClientDataButton.topAnchor.constraint(equalTo: phoneNumberText.bottomAnchor , constant: 20),
            addClientDataButton.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            addClientDataButton.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -20),
            addClientDataButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        
        addClientDataButton.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        
    }
    func showErrorMessage(_ message : String){
        SCLAlertView().showError("Error", subTitle: message) // Error
    }

    @objc func handleAddClientData(){
        
        let client = Client()
        
        if(clientText.text?.isEmpty == false){
            client.complete_name =  clientText.text
            client.first_name = clientText.text
        }else{
            showErrorMessage("Agregar nombre")
            return
        }
        print("TEL:",(phoneNumberText.text?.count)!)
        if(phoneNumberText.text?.isEmpty == false){
            if((phoneNumberText.text?.count)! == 10){
                client.phone_number =  phoneNumberText.text
            }else{
                showErrorMessage("Ingresar numero valido")
                return
            }
        }else{
            showErrorMessage("Agregar numero telefonico")
            return
        }
        
        client._id = "none"
        
       
        
        listener?.onClientSaved(client: client)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

