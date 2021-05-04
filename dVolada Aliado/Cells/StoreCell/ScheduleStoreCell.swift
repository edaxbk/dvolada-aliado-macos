//
//  ScheduleStoreCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 25/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class ScheduleStoreCell: UICollectionViewCell {
      
    
    var index : Int? {
        didSet {
            switch index {
            case 0:
                dayLabel.text = "Lunes"
                break
            case 1:
                dayLabel.text = "Martes"
                break
            case 2:
                dayLabel.text = "Miercoles"
                break
            case 3:
                dayLabel.text = "Jueves"
                break
            case 4:
                dayLabel.text = "Viernes"
                break
            case 5:
                dayLabel.text = "Sabado"
                break
            case 6:
                dayLabel.text = "Domingo"
                break
            default:
                break
            }
        }
    }
    
    var schedule : Schedule? {
        didSet{
          
            if let h = schedule?.hourStart {
                if let h2 = schedule?.hourEnd{
                     rangeScheduleLabel.text = h + "-" + h2
                }
            }

            if (schedule?.isAvailable) == true{
                isAvailableLabel.text = "Activado"
            }else{
                isAvailableLabel.text = "Desactivado"
            }
          
        }
    }
    
    let dayLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    let rangeScheduleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.text = "9:30 - 21:50"
        label.textAlignment = .center
        return label
      }()
    
    let isAvailableLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.text = "Activado"
        label.textAlignment = .center
        return label
      }()
      
      override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(dayLabel)
        addSubview(rangeScheduleLabel)
        addSubview(isAvailableLabel)
        
            
        NSLayoutConstraint.activate([
            
            dayLabel.topAnchor.constraint(equalTo: topAnchor),
            dayLabel.leftAnchor.constraint(equalTo: leftAnchor),
            dayLabel.widthAnchor.constraint(equalToConstant: 200),
            dayLabel.heightAnchor.constraint(equalToConstant: frame.height / 2),

            rangeScheduleLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            rangeScheduleLabel.widthAnchor.constraint(equalToConstant: 200),
            rangeScheduleLabel.heightAnchor.constraint(equalToConstant: frame.height / 2),

            isAvailableLabel.topAnchor.constraint(equalTo: topAnchor),
            isAvailableLabel.rightAnchor.constraint(equalTo: rightAnchor),
            isAvailableLabel.widthAnchor.constraint(equalToConstant: 200),
            isAvailableLabel.heightAnchor.constraint(equalToConstant: frame.height),
          
        ])
                      
      }
        
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

}
