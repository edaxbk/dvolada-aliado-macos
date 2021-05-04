//
//  headerImg.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 21/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImage)
        addSubview(scheduleBtn)
        addSubview(dishBtn)
        addSubview(tripsBtn)
        addSubview(logo)
        addSubview(calflabel)
        addSubview(tripsLabel)
        addSubview(tripsText)
        addSubview(dateLabel)
        addSubview(dateText)
        addSubview(lineBottonV)
        addSubview(lineBottonH)
        addSubview(closeSessionBtn)
        
        
        
        
        NSLayoutConstraint.activate([
            
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.leftAnchor.constraint(equalTo: leftAnchor),
            bgImage.rightAnchor.constraint(equalTo: rightAnchor),
            bgImage.heightAnchor.constraint(equalToConstant: frame.height / 3),
            
            scheduleBtn.topAnchor.constraint(equalTo: bgImage.topAnchor ,constant: 40),
            scheduleBtn.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            scheduleBtn.widthAnchor.constraint(equalToConstant: 30),
            scheduleBtn.heightAnchor.constraint(equalToConstant: 30),
            
            dishBtn.topAnchor.constraint(equalTo: scheduleBtn.bottomAnchor,constant: 30),
            dishBtn.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            dishBtn.widthAnchor.constraint(equalToConstant: 30),
            dishBtn.heightAnchor.constraint(equalToConstant: 30),
            
            tripsBtn.topAnchor.constraint(equalTo: dishBtn.bottomAnchor,constant: 30),
            tripsBtn.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            tripsBtn.widthAnchor.constraint(equalToConstant: 30),
            tripsBtn.heightAnchor.constraint(equalToConstant: 30),
            
            
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: bgImage.centerYAnchor),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),
            
            calflabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            calflabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: -30),
            calflabel.heightAnchor.constraint(equalToConstant: 60),
            calflabel.widthAnchor.constraint(equalToConstant: frame.width / 2),
            
            tripsLabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor),
            tripsLabel.leftAnchor.constraint(equalTo: leftAnchor),
            tripsLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            tripsLabel.heightAnchor.constraint(equalToConstant: frame.height / 8),
            
            tripsText.bottomAnchor.constraint(equalTo: tripsLabel.bottomAnchor,constant: -5),
            tripsText.leftAnchor.constraint(equalTo: leftAnchor),
            tripsText.widthAnchor.constraint(equalToConstant: frame.width/2),
            tripsText.heightAnchor.constraint(equalToConstant: frame.height / 20),
            
            dateLabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: frame.width/2),
            dateLabel.heightAnchor.constraint(equalToConstant: frame.height / 8),
            
            dateText.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: -5),
            dateText.rightAnchor.constraint(equalTo: rightAnchor),
            dateText.widthAnchor.constraint(equalToConstant: frame.width/2),
            dateText.heightAnchor.constraint(equalToConstant: frame.height / 20),
            
            lineBottonV.bottomAnchor.constraint(equalTo: tripsLabel.bottomAnchor),
            lineBottonV.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineBottonV.widthAnchor.constraint(equalToConstant: 1),
            lineBottonV.heightAnchor.constraint(equalToConstant: frame.height / 14 ),
            
            lineBottonH.bottomAnchor.constraint(equalTo: tripsLabel.bottomAnchor),
            lineBottonH.leftAnchor.constraint(equalTo: leftAnchor),
            lineBottonH.rightAnchor.constraint(equalTo: rightAnchor),
            lineBottonH.heightAnchor.constraint(equalToConstant: 1),
            
            closeSessionBtn.topAnchor.constraint(equalTo: tripsLabel.bottomAnchor,constant: 20),
            closeSessionBtn.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            closeSessionBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            closeSessionBtn.heightAnchor.constraint(equalToConstant: frame.height / 12),
            
        ])
        
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
