//
//  ModificadorCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

protocol AddTableViewCellDelegate: class {
    func didPressButtonAdd(sender: UIButton)
    func didPressButtonEdit(sender: UIButton)

}

class ModificadorCell: UITableViewCell, UITableViewDelegate {
    
    let modId = "modId"
    
    weak var delegate : AddTableViewCellDelegate?

    var modificador : Modifier? {
        didSet{
            
            if let name = modificador?.title{
                nameLabel.text = name
            }
            if (modificador?.isOptional == true){
                optionLabel.text = "Obligatorio"
            }else{
                optionLabel.text = "Opcional"
            }
            if let limit = modificador?.option_selection_length{
                optionLabel.text = " \(optionLabel.text!), limite: \(limit)"
            }else{
                optionLabel.text = " \(optionLabel.text!), limite: null"
            }

            self.tableView.reloadData()
        }
    }
    
    let myView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints =  false
        view.backgroundColor = .orange
        return view
    }()
    
    var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.backgroundColor =  .white
        
        return table
    }()
    
    var addButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(15)
        btn.setTitle("AGREGAR", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let editButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.09428814799, green: 0.8156581521, blue: 0.0763380453, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(15)
        btn.setTitle("EDITAR", for: .normal)
        btn.setTitleColor(.white , for: .normal)
        return btn
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Modificador"
        label.textColor = .white
        return label
    }()
    let optionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Optional"
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate =  self
        
        
        isEditing = true
        selectionStyle = .none
        
        tableView.isEditing = false
        tableView.isScrollEnabled = false
        
        
        backgroundColor = .white
        tableView.backgroundColor = .white
        addSubview(myView)
        addSubview(tableView)
        myView.addSubview(nameLabel)
        myView.addSubview(optionLabel)
        myView.addSubview(editButton)
        myView.addSubview(addButton)

        NSLayoutConstraint.activate([
            
            myView.topAnchor.constraint(equalTo: topAnchor),
            myView.heightAnchor.constraint(equalToConstant: 150),
            myView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            myView.leftAnchor.constraint(equalTo: leftAnchor),
            myView.rightAnchor.constraint(equalTo: rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: myView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo:rightAnchor),
         
            nameLabel.topAnchor.constraint(equalTo: myView.topAnchor),
            nameLabel.widthAnchor.constraint(equalTo: myView.widthAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            optionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            optionLabel.widthAnchor.constraint(equalTo: myView.widthAnchor),
            optionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            addButton.topAnchor.constraint(equalTo: optionLabel.bottomAnchor,constant: 20),
            addButton.leftAnchor.constraint(equalTo: myView.leftAnchor,constant: 20),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            editButton.topAnchor.constraint(equalTo: optionLabel.bottomAnchor,constant: 20),
            editButton.leftAnchor.constraint(equalTo: addButton.rightAnchor,constant: 20),
            editButton.widthAnchor.constraint(equalToConstant: 100),
            editButton.heightAnchor.constraint(equalToConstant: 50),
            
           
        ])
        tableView.register( UITableViewCell.self, forCellReuseIdentifier: modId)
        
        addButton.addTarget(self, action: #selector(addButon), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButon), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editButon(sender: UIButton) {
        delegate?.didPressButtonEdit(sender: sender)
    }
    @objc func addButon(sender: UIButton) {
        delegate?.didPressButtonAdd(sender: sender)
    }
}

extension ModificadorCell : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modificador?.options!.count ?? 500
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: modId, for: indexPath)
        cell.textLabel?.text =  modificador?.options?[indexPath.item].name
        cell.selectionStyle = .none
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "$ " + String((modificador?.options![indexPath.item].fee!)!)
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        cell.textLabel?.text = modificador?.options![indexPath.item].name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cell.topAnchor),
            label.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.rightAnchor.constraint(equalTo: cell.rightAnchor),
        ])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
