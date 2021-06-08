//
//  MenuStoreCollection.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import NVActivityIndicatorView

class MenuStoreTableView : UIViewController, UITableViewDelegate {
    
    var menuID = "menuID"
    var listOfMenu = Array<Menu>()
    
    override func viewWillAppear(_ animated: Bool){
        
        ServerHelper.shared.getMenuFromStoreAll(id: (LocalHelper.shared.getClient()?._id)!) { (arrayMenu) in
            self.listOfMenu.removeAll()
            self.listOfMenu.append(contentsOf: arrayMenu)
            self.tableView.reloadData()
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
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.addTarget(self, action: #selector(addMenuBtn), for: .touchUpInside)
        button.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: (navigationController?.navigationBar.frame.height ?? 0) + 20 ),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
        ])
        
        tableView.register( MenuStoreCell.self, forCellReuseIdentifier: menuID)
    }
    @objc func addMenuBtn(_sender : UIButton) {
        let menuCollection = AddNewMenuController()
        navigationController?.pushViewController(menuCollection, animated: true)
    }
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MenuStoreTableView : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuID, for: indexPath) as! MenuStoreCell
        cell.menu =  listOfMenu[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //Eliminar
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            ServerHelper.shared.deleteCategoryMenuStore(id: listOfMenu[indexPath.item]._id!) { (success) in
                self.listOfMenu.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    //-------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dishColelction = DishesMenuStoreTableView()
        dishColelction.menu = listOfMenu[indexPath.item]
        self.navigationController?.pushViewController(dishColelction, animated: true)
    }
    
}
