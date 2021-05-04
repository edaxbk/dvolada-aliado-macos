//
//  ModifierDishTableView.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 15/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit
protocol ModifierListener {
    func onModifierSelected(modifier : Modifier)
}

class ModifierDishTableView : UIViewController, UITableViewDelegate {
    
    var menuID = "menuID"
    var modificadorID = "modificadorID"
    var modifier = Modifier ()
    var modifiers = Array<Modifier>()
    
    var listener : ModifierListener?
    
    override func viewWillAppear(_ animated: Bool) {
        ServerHelper.shared.getModifiersStore(id: (LocalHelper.shared.getClient()?._id)!) { (getModifiers) in
            self.modifiers.removeAll()
            self.modifiers.append(contentsOf: getModifiers)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.backgroundColor =  .white
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate =  self
    
                
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.addTarget(self, action: #selector(addMenuBtn), for: .touchUpInside)
        button.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: (navigationController?.navigationBar.frame.height ?? 0) + 20 ),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
        ])
        
        tableView.register( ModificadorCell.self, forCellReuseIdentifier: menuID)
    }
    @objc func addMenuBtn(_sender : UIButton) {
        let modifierControler = AddNewModificadorControll()
        modifierControler.title = "Agregar"
        navigationController?.pushViewController(modifierControler, animated: true)
    }
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
}

extension ModifierDishTableView : AddTableViewCellDelegate {
    func didPressButtonAdd(sender: UIButton) {
        print("Presionaster Add ::",sender.tag)
        print("MODIFICADOR ID ::", modifiers[sender.tag].title ?? "title")
        listener?.onModifierSelected(modifier: modifiers[sender.tag])
        self.navigationController?.popViewController(animated: true)
    }
    func didPressButtonEdit(sender: UIButton) {
        let modifierControler = EditModificadorControll()
        modifierControler.title = "Editar"
        modifierControler.modifier = modifiers[sender.tag]
        self.navigationController?.pushViewController(modifierControler, animated: true)
    }
}

extension ModifierDishTableView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuID) as! ModificadorCell
        cell.delegate = self
        cell.addButton.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.modificador = modifiers[indexPath.item]
        cell.tableView.heightAnchor.constraint(equalToConstant: CGFloat(modifiers[indexPath.item].options!.count * 50)).isActive = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //Eliminar
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            ServerHelper.shared.deleteModifiersStore(id: modifiers[indexPath.item]._id!){ (succes) in
                 self.modifiers.remove(at: indexPath.row)
                 tableView.deleteRows(at: [indexPath], with: .fade)
             }
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
}
