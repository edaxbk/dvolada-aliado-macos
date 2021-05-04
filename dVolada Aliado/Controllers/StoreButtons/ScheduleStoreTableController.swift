//
//  ScheduleStoreTableController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 09/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

class ScheduleStoreTableController: UIViewController {
    
    var day = ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"]

    var tableViewController : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .green
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        ServerHelper.shared.getStoreById(id: (LocalHelper.shared.getClient()?._id)!) { (getstore) in
            self.store = getstore
            DispatchQueue.main.async {
                self.tableViewController.reloadData()
                //self.collectionView.reloadData()
            }
        } onFailure: { (err) in
            print("Error in get store::",err)
        }
    }
    
    var scheduleID = "scheduleID"
    
    var store: Store?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.dataSource = self
        tableViewController.delegate = self

        view.addSubview(tableViewController)
        
        view.backgroundColor = .white
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        tableViewController.register(ScheduleStoreCell.self, forCellReuseIdentifier: scheduleID)
        //tableViewController.register(UINib(nibName: "TravelViewCell", bundle: nil), forCellReuseIdentifier: scheduleID)
        
        NSLayoutConstraint.activate([
        
            tableViewController.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableViewController.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableViewController.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableViewController.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        ])
            
        
        
    }
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
}


extension ScheduleStoreTableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store?.schedule!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: scheduleID, for: indexPath) as! ScheduleStoreCell
        cell.schedule = store?.schedule?[indexPath.item]
        cell.dayLabel.text = day[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.2
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Hi"
    }
    

}

extension ScheduleStoreTableController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("press on did selectroway")

        let dayController = DayScheduleController()
        dayController.dayLabel.text = day[indexPath.item]
        dayController.schedule = store?.schedule?[indexPath.item]
        dayController.x = indexPath.item
        self.navigationController?.pushViewController(dayController, animated: true)
    }

}
