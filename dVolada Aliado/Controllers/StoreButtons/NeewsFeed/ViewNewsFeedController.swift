//
//  ViewNeewsFeedController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 24/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit


class NewsFeedViewController : UIViewController, UITableViewDelegate {
    
    var newsFeedId = "newsFeedID"
    
    var listOfNewsFeed = Array<NewsFeed>()
    
    var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .plain )
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.backgroundColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return table
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.listOfNewsFeed.removeAll()

        ServerHelper.shared.getNewsFeedByStore(id: (LocalHelper.shared.getClient()?._id)!) { list in
            
            print(list.count)
            self.listOfNewsFeed.append(contentsOf: list)
            self.listOfNewsFeed.reverse()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Publicaciones"
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
        ])
        
        tableView.register( NewsFeedCell.self, forCellReuseIdentifier: newsFeedId)
        
    }
}


extension NewsFeedViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listOfNewsFeed.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: newsFeedId, for: indexPath) as! NewsFeedCell
        cell.newsFeed = listOfNewsFeed[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //onDishSelected(dish: listOfNewsFeed[indexPath.section].menu![indexPath.item])
        /*let dishColelction = DishesMenuStoreTableView()
         dishColelction.menu = listOfNewsFeed[indexPath.item]
         self.navigationController?.pushViewController(dishColelction, animated: true)*/
    }
    
    
}

