//
//  AddNewModifierController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 24/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import SCLAlertView


class AddNewModificadorControll : UIViewController,UITableViewDelegate  {
    
    let radioController = RadioButtonController()
    
    let modId = "modId"
    var opcArray = Array<Options>()

    
    var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.backgroundColor =  .white
        return table
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Crea tu Modificador"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let nameModificadorText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(15)
        text.placeholder = ("Titulo")
        return text
    }()
    
    let textLable : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "¿Es olbigatorio esta sección?"
        label.font = label.font?.withSize(18)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let optional : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let optionalLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Opcional"
        label.textAlignment = .left
        return label
    }()
    
    let required : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let requiredLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Obligatorio"
        label.textAlignment = .left
        return label
    }()
    
    let nameText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(15)
        text.placeholder = ("Nombre")
        return text
    }()
    
    let priceAddText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(15)
        text.placeholder = ("Precio Adicional")
        text.keyboardType = .numberPad
        return text
    }()
    
    let limitSelectedText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(15)
        text.placeholder = ("Limite de selección")
        text.keyboardType = .numberPad
        return text
    }()
    
    let addOpcBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(15)
        btn.setTitle("AGREGAR OPCION", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    
    
    let confirmBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(15)
        btn.setTitle("CREAR MODIFICADOR", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    @objc func optionalBtn(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @objc func requiredBtn(_ sender: UIButton) {
        radioController.buttonArrayUpdated(buttonSelected: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        nameModificadorText.becomeFirstResponder()
        
        optional.addTarget(self, action: #selector(optionalBtn), for: .touchUpInside)
        required.addTarget(self, action: #selector(requiredBtn), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        radioController.buttonsArray = [optional,required]
        radioController.buttonArrayUpdated(buttonSelected: optional)
        
        view.addSubview(titleLabel)
        view.addSubview(nameModificadorText)
        view.addSubview(textLable)
        view.addSubview(optional)
        view.addSubview(optionalLabel)
        view.addSubview(required)
        view.addSubview(requiredLabel)
        
        view.addSubview(nameText)
        view.addSubview(priceAddText)
        view.addSubview(addOpcBtn)
        view.addSubview(tableView)
        view.addSubview(limitSelectedText)
        view.addSubview(addOpcBtn)
        view.addSubview(confirmBtn)
        
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor ),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            nameModificadorText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameModificadorText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            nameModificadorText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nameModificadorText.heightAnchor.constraint(equalToConstant: 30),
            
            textLable.topAnchor.constraint(equalTo: nameModificadorText.bottomAnchor,constant: 20),
            textLable.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            textLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            textLable.heightAnchor.constraint(equalToConstant: 30),
            
            optional.topAnchor.constraint(equalTo: textLable.bottomAnchor,constant: 20),
            optional.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            optional.heightAnchor.constraint(equalToConstant: 20),
            optional.widthAnchor.constraint(equalToConstant: 20),
            
            optionalLabel.topAnchor.constraint(equalTo: textLable.bottomAnchor,constant: 20),
            optionalLabel.leftAnchor.constraint(equalTo: optional.rightAnchor, constant: 5),
            optionalLabel.heightAnchor.constraint(equalToConstant: 20),
            optionalLabel.widthAnchor.constraint(equalToConstant: 100),
            
            required.topAnchor.constraint(equalTo: optional.bottomAnchor,constant: 20),
            required.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            required.heightAnchor.constraint(equalToConstant: 20),
            required.widthAnchor.constraint(equalToConstant: 20),
            
            requiredLabel.topAnchor.constraint(equalTo: optionalLabel.bottomAnchor,constant: 20),
            requiredLabel.leftAnchor.constraint(equalTo: required.rightAnchor, constant: 5),
            requiredLabel.heightAnchor.constraint(equalToConstant: 20),
            requiredLabel.widthAnchor.constraint(equalToConstant: 100),
            
            nameText.topAnchor.constraint(equalTo: requiredLabel.bottomAnchor,constant: 30),
            nameText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            nameText.heightAnchor.constraint(equalToConstant: 20),
            nameText.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            
            priceAddText.topAnchor.constraint(equalTo: requiredLabel.bottomAnchor,constant: 30),
            priceAddText.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            priceAddText.heightAnchor.constraint(equalToConstant: 20),
            priceAddText.widthAnchor.constraint(equalToConstant: 150),
            
            addOpcBtn.topAnchor.constraint(equalTo: priceAddText.bottomAnchor,constant: 30),
            addOpcBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            addOpcBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addOpcBtn.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: addOpcBtn.bottomAnchor,constant: 20 ),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 150),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            
            limitSelectedText.topAnchor.constraint(equalTo: tableView.bottomAnchor,constant: 20),
            limitSelectedText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            limitSelectedText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            limitSelectedText.heightAnchor.constraint(equalToConstant: 40),
            
            confirmBtn.topAnchor.constraint(equalTo: limitSelectedText.bottomAnchor,constant: 20),
            confirmBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            confirmBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant: 40),
            
            
            
        ])
        tableView.register( UITableViewCell.self, forCellReuseIdentifier: modId)
        
         addOpcBtn.addTarget(self, action: #selector(addOpcAction), for: .touchUpInside)
        confirmBtn.addTarget(self, action: #selector(createModifierAction), for: .touchUpInside)

    }
    func showErrorMessage(_ message : String){
        SCLAlertView().showError("Error", subTitle: message) // Error
    }
   
    @objc func createModifierAction(sender: UIButton){
        let modifiers = Modifier()

        if((nameModificadorText.text?.isEmpty)!){
            showErrorMessage("Titulo")
            nameModificadorText.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return
        }else{
            nameModificadorText.backgroundColor = .white
            modifiers.title = nameModificadorText.text
        }
        
        if(optional.isSelected == true){
            print("is optional")
            modifiers.isOptional = false
        }
        if(required.isSelected == true){
            print("is required")
            modifiers.isOptional = true
        }
        
        if(opcArray.isEmpty){
            showErrorMessage("Se necesita una opción")
            return
        }else{
            print("Agregando opcArray",opcArray)
            modifiers.options = opcArray
        }
        
        if((limitSelectedText.text?.isEmpty)!){
            modifiers.option_selection_length = 0
        }else{
            modifiers.option_selection_length = Int(limitSelectedText.text!)
        }
        
        ServerHelper.shared.postModifierFromStore(modifier: modifiers, store: LocalHelper.shared.getClient()!) { (succes) in
            print("OK")
            self.navigationController?.popViewController(animated: true)
        } onFailure: { (err) in
            print("ERR::",err)
        }

                
       
        
    }
    @objc func addOpcAction(sender: UIButton){
        
        if((nameText.text?.isEmpty)! || (priceAddText.text?.isEmpty)!){
            showErrorMessage("Nombre y precio")
            nameText.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            priceAddText.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           return
        }else{
            let opc = Options()
            nameText.backgroundColor = .white
            priceAddText.backgroundColor = .white
            opc.name = nameText.text
            opc.fee = Int(priceAddText.text!)
            opcArray.append(opc)
        }
        tableView.reloadData()
        
        nameText.text = ""
        priceAddText.text = ""
    }
}

extension AddNewModificadorControll : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opcArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: modId, for: indexPath)
        cell.textLabel?.backgroundColor = .white
        cell.selectionStyle = .none
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "$ " + String(opcArray[indexPath.item].fee!)
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        cell.textLabel?.text = opcArray[indexPath.item].name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cell.topAnchor,constant: 5),
            label.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.rightAnchor.constraint(equalTo: cell.rightAnchor),
        ])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //Eliminar
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print("Eliminar modifier")
                 self.opcArray.remove(at: indexPath.row)
                 tableView.deleteRows(at: [indexPath], with: .fade)
             
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
}

//Clase para crear un ui radio button
class RadioButtonController: NSObject {
    
    var buttonsArray: [UIButton]! {
        didSet {
            for b in buttonsArray {
                b.setImage(UIImage(named: "radio_off"), for: .normal)
                b.setImage(UIImage(named: "radio_on"), for: .selected)
            }
        }
    }
    var selectedButton: UIButton?
   
    /*
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }
    */
    func buttonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
}
