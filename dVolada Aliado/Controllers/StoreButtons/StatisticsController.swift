//
//  StatisticsController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class StatisticsController : UIViewController{
    
     var blackView : UIView = {
         let vista = UIView()
         vista.translatesAutoresizingMaskIntoConstraints = false
        vista.backgroundColor = UIColor.black
         return vista
     }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Selecciona tu mes"
        label.textAlignment = .center
        label.textColor = .white
    return label
    }()
    
    let subLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Ganancias"
        label.textAlignment = .center
        label.textColor = .white
    return label
    }()
    
    let selectMonthBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitle("Seleccionar mes", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.tintColor = .white
        return btn
    }()
    
    let segmentControl : UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false

        segment.backgroundColor = .black
        segment.selectedSegmentTintColor = .orange

        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segment.setTitleTextAttributes(titleTextAttributes, for:.normal)
        
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segment.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        
        segment.insertSegment(withTitle: "TERMINADOS", at: 0, animated: true)
        segment.insertSegment(withTitle: "CANCELADOS POR COMERCIO", at: 1, animated: true)
        segment.insertSegment(withTitle: "CANCELADOS POR CLIENTE", at: 2, animated: true)
                
        segment.selectedSegmentIndex = 0
        
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
      
        view.addSubview(blackView)
        
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        view.addSubview(selectMonthBtn)
        view.addSubview(segmentControl)
       
        NSLayoutConstraint.activate([
            
            blackView.topAnchor.constraint(equalTo: view.topAnchor,constant: (self.navigationController?.navigationBar.frame.height)!),
            blackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blackView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            
            titleLabel.topAnchor.constraint(equalTo: blackView.topAnchor , constant: 40),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            subLabel.heightAnchor.constraint(equalToConstant: 40),
            
            selectMonthBtn.bottomAnchor.constraint(equalTo: blackView.bottomAnchor,constant: -100),
            selectMonthBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectMonthBtn.widthAnchor.constraint(equalToConstant: 200),
            selectMonthBtn.heightAnchor.constraint(equalToConstant: 40),
            
            segmentControl.bottomAnchor.constraint(equalTo: blackView.bottomAnchor),
            segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            segmentControl.heightAnchor.constraint(equalToConstant: 80),
              
        ])
//        confirmBtn.addTarget(self, action: #selector(pushMenuStore), for: .touchUpInside)
    }
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
}
