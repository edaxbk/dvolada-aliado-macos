//
//  myTableView.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 11/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

class myTableView : UIViewController, UITableViewDelegate {
    
    let cellID = "cellId"
    let headID =  "headId"
    
    var menuID = "menuID"
    var listOfMenu = Array<Menu>()
    
    override func viewWillAppear(_ animated: Bool) {
        ServerHelper.shared.getMenuFromStore(id: (LocalHelper.shared.getClient()?._id)!) { (arrayMenu) in
            self.listOfMenu.removeAll()
            
            self.listOfMenu.append(contentsOf: arrayMenu)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor =  .red
        return table
    }()
    
    var contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        view.backgroundColor = .cyan
        view.addSubview(contentView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 70),
            
            tableView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
      
        ])
        
        tableView.register( MyCustomCell.self, forCellReuseIdentifier: cellID)
        
    }
}

extension myTableView : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MyCustomCell
        return cell
    }
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
