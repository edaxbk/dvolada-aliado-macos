//
//  AddNewMenuController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

class AddNewMenuController : UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        view.addSubview(nameMenuText)
        view.addSubview(lineBottonH)
        view.addSubview(confirmBtn)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo:   view.topAnchor,constant: 90),
            titleLabel.leftAnchor.constraint(equalTo:   view.leftAnchor,constant: 20),
            titleLabel.rightAnchor.constraint(equalTo:   view.rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameMenuText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 40),
            nameMenuText.leftAnchor.constraint(equalTo:   view.leftAnchor,constant: 20),
            nameMenuText.rightAnchor.constraint(equalTo:   view.rightAnchor, constant: -20),
            nameMenuText.heightAnchor.constraint(equalToConstant: 40),
            
            lineBottonH.bottomAnchor.constraint(equalTo:nameMenuText.bottomAnchor),
            lineBottonH.leftAnchor.constraint(equalTo:   view.leftAnchor,constant: 20),
            lineBottonH.rightAnchor.constraint(equalTo:   view.rightAnchor,constant: -20),
            lineBottonH.heightAnchor.constraint(equalToConstant: 1),
            
            confirmBtn.topAnchor.constraint(equalTo: lineBottonH.bottomAnchor,constant: 50),
            confirmBtn.leftAnchor.constraint(equalTo:   view.leftAnchor,constant: 20),
            confirmBtn.rightAnchor.constraint(equalTo:   view.rightAnchor, constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant:   view.frame.height / 12),
            
        ])
        
        confirmBtn.addTarget(self, action: #selector(confimBtnAction), for: .touchUpInside)
        
    }
    
    @objc func confimBtnAction(_sender : UIButton) {
        
        if ((nameMenuText.text?.isEmpty)!){
            let alerta = UIAlertController(title: "Error", message: "Ingresar un nombre de menu", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alerta, animated: true)
            
        }else{
            
            ServerHelper.shared.postMenuFromStore(id: (LocalHelper.shared.getClient()?._id)!, title: nameMenuText.text!) { (menu) in
                self.navigationController?.popViewController(animated: true)
            } onFailure: { (err) in
                print("err:::",err)
            }
        }
    }
}
