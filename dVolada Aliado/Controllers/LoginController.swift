//
//  Login.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 23/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit
import SCLAlertView
import JGProgressHUD

class LoginController: UIViewController {
    
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
        text.textContentType = .emailAddress
        text.textColor = .black
        text.placeholder = (" Email")
        text.autocapitalizationType = .none
        text.keyboardType = .emailAddress
        text.autocorrectionType = .no
        text.attributedPlaceholder = NSAttributedString(string: "Correo",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return text
    }()
    
    let passwordTextField : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.placeholder = (" Password")
        text.textColor = .black
        text.isSecureTextEntry = true
        text.attributedPlaceholder = NSAttributedString(string: "Contraseña",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
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
        btn.layer.masksToBounds = true
        btn.setTitle("Iniciar Session", for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        btn.tintColor = .white
        return btn
    }()
    
    @objc func handleLogin() {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        
        
        if(!email!.isEmpty){
            if(!password!.isEmpty ){
                
                print("user::", email! ,"pass::",password!)
                
                let hud = JGProgressHUD()
                hud.textLabel.text = "Iniciando sesion"
                hud.show(in: self.view)
                
                ServerHelper.shared.login(email: email!, password: password!) { (store) in
                    
                    print("Store in login::",store.name!)
                    
                    hud.dismiss()
                    LocalHelper.shared.setClient(store)
                    let tabBarController = HomeTabBarController()
                    let nav = UINavigationController(rootViewController: tabBarController)
                    nav.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(nav, animated: true, completion: nil)
                
                } onFailure: { (error) in
                    hud.dismiss()
                    print("-->>Erro",error)
                    self.showErrorMessage("Error con usuario o contraseña Verifique sus datos");
                }
                
            }else{
                showErrorMessage("Se necesita una contraseña")
            }
        }else{
            showErrorMessage("Se necesita un email")
        }
        
    }
    
    func showErrorMessage(_ message : String){
        SCLAlertView().showError("Error", subTitle: message) // Error
    }
    
    
    let lineBottonH: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(logo)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(lineBottonH)
        view.addSubview(passwordTextField)
        view.addSubview(initSessionBtn)
        
        NSLayoutConstraint.activate([
            
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140),
            logo.widthAnchor.constraint(equalToConstant: 150),
            logo.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lineBottonH.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 2.5),
            lineBottonH.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50),
            lineBottonH.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -50),
            lineBottonH.heightAnchor.constraint(equalToConstant: 1),
            
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 5),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            initSessionBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20),
            initSessionBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50),
            initSessionBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            initSessionBtn.heightAnchor.constraint(equalToConstant: view.frame.height / 12),
            
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        initSessionBtn.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
