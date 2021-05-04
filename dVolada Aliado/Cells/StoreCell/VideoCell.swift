//
//  VideoCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit
import AVFoundation

class VideoCell: UICollectionViewCell {
    
    let imgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        img.isUserInteractionEnabled = true
        img.backgroundColor = .black
        return img
    }()
    
    let nameVideoLabel : UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.boldSystemFont(ofSize: 12)
      label.text = "00:00"
        label.textColor = .white
      label.backgroundColor = .clear
        label.textAlignment = .center
      return label
    }()
    
    var deleteBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 0.1847372516, blue: 0.1561645891, alpha: 1)
//        button.backgroundColor = .green
        return button
    }()
    
    var playerLayer: AVPlayerLayer?
       var player: AVPlayer?

        let playButton: UIButton = {
              let button = UIButton(type: .system)
              button.translatesAutoresizingMaskIntoConstraints = false
              let image = UIImage(systemName: "play.rectangle.fill")
              button.tintColor = UIColor.white
              button.setImage(image, for: .normal)
              return button
          }()
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .red
        
        addSubview(imgView)
        addSubview(nameVideoLabel)
        addSubview(deleteBtn)
        
        NSLayoutConstraint.activate([

            imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgView.widthAnchor.constraint(equalToConstant: frame.width),
            imgView.heightAnchor.constraint(equalToConstant: frame.height),

            nameVideoLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameVideoLabel.rightAnchor.constraint(equalTo: rightAnchor),
            nameVideoLabel.widthAnchor.constraint(equalToConstant:100),
            nameVideoLabel.heightAnchor.constraint(equalToConstant: 50),

            deleteBtn.topAnchor.constraint(equalTo: topAnchor),
            deleteBtn.rightAnchor.constraint(equalTo: rightAnchor),
            deleteBtn.widthAnchor.constraint(equalToConstant:50),
            deleteBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])

    }
    
 

    
    @objc func handlePlay( url: URL) {
             player = AVPlayer(url: url)
             playerLayer = AVPlayerLayer(player: player)
             playerLayer?.frame = imgView.bounds
             imgView.layer.addSublayer(playerLayer!)
     }
    
}
