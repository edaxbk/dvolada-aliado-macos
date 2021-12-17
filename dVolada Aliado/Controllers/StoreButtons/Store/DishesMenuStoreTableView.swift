//
//  MenuCollection.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 29/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit

class DishesMenuStoreTableView : UIViewController, UITableViewDelegate {
    
    var menuID = "menuID"
    var menu : Menu?
    
    var dishID = "dishID"
    
    override func viewWillAppear(_ animated: Bool) {
        ServerHelper.shared.getMenuFromStoreAll(id: (LocalHelper.shared.getClient()?._id)!) { (arrayMenu) in
            arrayMenu.map{ (menu) in
                if( self.menu?._id == menu._id){
                    self.menu = menu
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
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
        
        title = "Categorias"
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.addTarget(self, action: #selector(addDishBtn), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
      
        ])
        tableView.register( DishMenuStoreListCell.self, forCellReuseIdentifier: dishID)
    }
    
    @objc func addDishBtn(_sender : UIButton) {
        let dishController = AddNewDishController()
        dishController.menu = menu?._id
        self.navigationController?.pushViewController(dishController, animated: true)
    }
}


extension DishesMenuStoreTableView : UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vista = DishMenuStoreHeadView()
        vista.menu = menu
        return vista
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (menu?.menu?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dishID, for: indexPath) as! DishMenuStoreListCell
        cell.dishes = menu?.menu?[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = EditDishMenuController()
        controller.dish = menu?.menu![indexPath.item]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
