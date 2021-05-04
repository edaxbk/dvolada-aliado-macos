//
//  NewOrderController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 26/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit
import AVFoundation



class NewOrderController: UIViewController  {
    
    var player: AVAudioPlayer?
    var order : Order? {
        didSet {
            descLabel.text = "\(order!.client!.complete_name!) acaba dede realizar un nuevo pedido"
        }
    }

    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "¡Tienes un nuevo pedido!"
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    let descLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let viewOrderBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.masksToBounds = true
        btn.setTitle("Ver pedidos", for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        btn.tintColor = .white
        return btn
    }()
    
    
    @objc func handleDismiss(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(viewOrderBtn)
        
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            descLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descLabel.heightAnchor.constraint(equalToConstant: 80),
            
            viewOrderBtn.topAnchor.constraint(equalTo: descLabel.bottomAnchor,constant: 10),
            viewOrderBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            viewOrderBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            viewOrderBtn.heightAnchor.constraint(equalToConstant: 80),
            
        ])
        
        viewOrderBtn.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        playSound()
        
    }
    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "alert", withExtension: "mp3") else {
            print("NO AUDIO FOUND")
            return
            
        }

        do {
            
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)


            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}


