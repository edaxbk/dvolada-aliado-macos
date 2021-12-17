//
//  dayCollection.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 28/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class DayController : UIViewController {
    
    
    var isForOpen  = false
    var scheduleID = "scheduleID"
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
                openHourBtn.setTitle("Abierto \(h)", for: .normal)
            }
            
            if let h2 = schedule?.hourEnd{
                closeHourBtn.setTitle("Cerrado \(h2)", for: .normal)
            }
            
            switchAvailable.setOn(schedule?.isAvailable ?? false, animated: true)
        }
    }
    
    var switchAvailable : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    
    
    var hourPicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        return picker
    }()
    
    let cancelPickerBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.setTitle("Cancelar", for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    let confirmPickerBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.setTitle("Aceptar", for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    
    let dayLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "Dia"
        label.textAlignment = .left
        return label
    }()
    
    let openHourBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(showOpenTime), for: .touchUpInside)
        return btn
    }()
    
    let closeHourBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitle("Cerrado", for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(showCloseTime), for: .touchUpInside)
        return btn
    }()
    
    let confirmBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemPink
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 40
        btn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleConfirm() {
        print("update schedule in store")
        ServerHelper.shared.updateSchedule(store: LocalHelper.shared.getClient()!) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
        ServerHelper.shared.updateSchedule(store: LocalHelper.shared.getClient()!) { (store) in
            print(":: SCHEDULE ::",store.schedule!)
        }
        
    }
    
    
    @objc func showPickerTime() {
        
        view.addSubview(hourPicker)
        view.addSubview(cancelPickerBtn)
        view.addSubview(confirmPickerBtn)
        
        NSLayoutConstraint.activate([
            hourPicker.topAnchor.constraint(equalTo: closeHourBtn.bottomAnchor,constant: 20),
            hourPicker.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            hourPicker.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            hourPicker.heightAnchor.constraint(equalToConstant: 200),
            
            cancelPickerBtn.topAnchor.constraint(equalTo: hourPicker.bottomAnchor,constant: 20),
            cancelPickerBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40),
            cancelPickerBtn.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            cancelPickerBtn.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPickerBtn.topAnchor.constraint(equalTo: hourPicker.bottomAnchor,constant: 20),
            confirmPickerBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40),
            confirmPickerBtn.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            confirmPickerBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        cancelPickerBtn.addTarget(self, action: #selector(hidePickerTime), for: .touchUpInside)
        confirmPickerBtn.addTarget(self, action: #selector(hidePickerTime), for: .touchUpInside)
    }
    
    @objc func showOpenTime(){
        isForOpen = true
        showPickerTime()
    }
    
    @objc func showCloseTime(){
        isForOpen = false
        showPickerTime()
    }
    
    
    
    @objc func hidePickerTime(_sender : UIButton) {
        
        let calendar = Calendar.current
        let tempHour = calendar.component(.hour, from: hourPicker.date)
        let tempMinute = calendar.component(.minute, from: hourPicker.date)
        
        print("hour: \(tempHour) minute: \(tempMinute)")
        
        hourPicker.removeFromSuperview()
        cancelPickerBtn.removeFromSuperview()
        confirmPickerBtn.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(switchAvailable)
        view.addSubview(dayLabel)
        view.addSubview(openHourBtn)
        view.addSubview(closeHourBtn)
        view.addSubview(confirmBtn)
        
        NSLayoutConstraint.activate([
            
            switchAvailable.topAnchor.constraint(equalTo: view.topAnchor ,constant: 70),
            switchAvailable.rightAnchor.constraint(equalTo: view.rightAnchor ,constant: -20),
            
            dayLabel.topAnchor.constraint(equalTo: switchAvailable.bottomAnchor,constant: 20),
            dayLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            dayLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            dayLabel.heightAnchor.constraint(equalToConstant: 100),
            
            openHourBtn.topAnchor.constraint(equalTo: dayLabel.bottomAnchor,constant: 20),
            openHourBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            openHourBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            openHourBtn.heightAnchor.constraint(equalToConstant: 60),
            
            closeHourBtn.topAnchor.constraint(equalTo: openHourBtn.bottomAnchor,constant: 20),
            closeHourBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            closeHourBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            closeHourBtn.heightAnchor.constraint(equalToConstant: 60),
            
            confirmBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor ,constant: -40),
            confirmBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            confirmBtn.widthAnchor.constraint(equalToConstant: 80),
            confirmBtn.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        confirmBtn.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)

    }
    
    
}
