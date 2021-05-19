//
//  MenuStoreController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

class MenuStoreController: UIViewController, UITableViewDelegate, DishListener , CartListener, GeneralCartListener, TransactionListener {
    
    func onTransactionSuccess(transaction: Order) {
        print("on transactionlistener")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    var direction : Direction?
    
    func onDishSelected(dish: Dish) {
        let flowLayout = UICollectionViewFlowLayout()
        let controller = DishController(collectionViewLayout: flowLayout)
        controller.listener = self
        controller.dish = dish
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onItemAdded(cart: Cart) {
        listOfCart.append(cart)
        addProductButton.isHidden = false
        view.layoutIfNeeded()
    }

    var listOfMenu = Array<Menu>()
    var listOfCart = Array<Cart>()
    
    var menuID = "menuID"
    
    override func viewWillAppear(_ animated: Bool) {
        ServerHelper.shared.getMenuFromStore(id: (LocalHelper.shared.getClient()?._id)!) { (arrayMenu) in
            self.listOfMenu.removeAll()
            
            arrayMenu.forEach { (menu) in
                
                if(menu.isAvailable ?? false){
                    
                    var listOfDishes = Array<Dish>()
                    
                    var elements = -1
                    
                    menu.menu!.forEach { (dish) in
                                                
                        if(dish.isAvailable!){
                            listOfDishes.append(dish)
                            elements = elements + 1
                        }
                    }
                    
                    menu.menu = listOfDishes
                    
                    
                }
                self.listOfMenu.append(menu)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var addProductButton : UIButton =  {
        
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.94, green: 0.42, blue: 0.00, alpha: 1.00)
        view.setTitle("Ver Carrito", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(viewCart), for: .touchUpInside)
        view.isHidden = true
        
        return view
    }()
    
    var tableView : UITableView = {
        let table = UITableView(frame: .zero
                                , style: .grouped )
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.backgroundColor =  .white
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(addProductButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: (navigationController?.navigationBar.frame.height ?? 0) + 20 ),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            
            addProductButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addProductButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            addProductButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            addProductButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        tableView.register( DishMenuStoreListCell.self, forCellReuseIdentifier: menuID)
    }
    @objc func addMenuBtn(_sender : UIButton) {
        let menuCollection = AddNewMenuController()
        navigationController?.pushViewController(menuCollection, animated: true)
    }
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    func onListUpdate(cart: Array<Cart>) {
        
        print("ON LIST UPDATE")
        listOfCart.removeAll()
        listOfCart.append(contentsOf: cart)
        
        if(listOfCart.isEmpty){
            addProductButton.isHidden = true
            view.layoutIfNeeded()
        }
    }
    
    @objc func viewCart(){
        print("ESTOY EN VIEW CART")
        let cartController = CartController(collectionViewLayout: UICollectionViewFlowLayout())
        cartController.list = listOfCart
        cartController.direction = direction
        cartController.store = LocalHelper.shared.getClient()
        cartController.listener = self
        cartController.listener2 = self
        
        let nav = UINavigationController(rootViewController: cartController)
        navigationController?.present(nav, animated: true, completion: nil)
    }
    
}

extension MenuStoreController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listOfMenu.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        
        label.text = "  " + listOfMenu[section].title!
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMenu[section].menu!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuID, for: indexPath) as! DishMenuStoreListCell
        cell.dishes = listOfMenu[indexPath.section].menu?[indexPath.item]
        cell.isAvailableLabel.isHidden = true
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        onDishSelected(dish: listOfMenu[indexPath.section].menu![indexPath.item])
        /*let dishColelction = DishesMenuStoreTableView()
         dishColelction.menu = listOfMenu[indexPath.item]
         self.navigationController?.pushViewController(dishColelction, animated: true)*/
    }
    
}
