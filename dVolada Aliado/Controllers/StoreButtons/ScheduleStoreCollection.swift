//
//  ScheduleStoreCollection.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit
import Alamofire

class ScheduleStoreCollection : UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    override func viewWillAppear(_ animated: Bool) {
        ServerHelper.shared.getStoreById(id: (LocalHelper.shared.getClient()?._id)!) { (getstore) in
            self.store = getstore
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } onFailure: { (err) in
            print("Error in get store::",err)
        }
    }
    
    var scheduleID = "scheduleID"
    
    var store: Store?
    
    var day = ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        collectionView.backgroundColor = .white
        collectionView.register(ScheduleStoreCell.self, forCellWithReuseIdentifier: scheduleID)
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store?.schedule!.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: scheduleID, for: indexPath) as! ScheduleStoreCell
        cell.schedule = store?.schedule?[indexPath.item]
        cell.dayLabel.text = day[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.2
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dayController = DayScheduleController()
        dayController.dayLabel.text = day[indexPath.item]
        dayController.schedule = store?.schedule?[indexPath.item]
        dayController.x = indexPath.item
        self.navigationController?.pushViewController(dayController, animated: true)
    }
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
}
