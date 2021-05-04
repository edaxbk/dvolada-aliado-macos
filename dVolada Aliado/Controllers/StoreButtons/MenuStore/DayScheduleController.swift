//
//  DayScheduleController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class DayScheduleController: UIViewController {
    
    var scheduleID = "scheduleID"
    var store = LocalHelper.shared.getClient()
    var x = 0
    var schedule : Schedule? {
        didSet{
            
            if let h = schedule?.hourStart {
                openHourBtn.setTitle("\(h)", for: .normal)
            }
            if let h2 = schedule?.hourEnd{
                closeHourBtn.setTitle("\(h2)", for: .normal)
            }
            switchAvailable.setOn((schedule?.isAvailable!)!, animated: true)
        }
    }
    
    var viewBlack : UIView = {
        let viewblack =  UIView()
        viewblack.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        viewblack.translatesAutoresizingMaskIntoConstraints = false
        return viewblack
    }()
    
    var switchAvailable : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    //picker-+-------------
    var hourPicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white
        picker.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        picker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        picker.locale = Locale(identifier: "en_GB")
        return picker
    }()
    
    var hourPicker2 : UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white
        picker.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        picker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.layer.cornerRadius = 20
        picker.locale = Locale(identifier: "en_GB")
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
    
    //picker-+-------------
    
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
        return btn
    }()
    let openHourLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Abierto"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .left
        return label
    }()
    
    let closeHourBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitle("Cerrado", for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    let closeHourLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Cerrado"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .left
        return label
    }()
    
    let confirmBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemPink
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 40
        btn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("STORE:::",store?.name!)
        
        view.addSubview(switchAvailable)
        view.addSubview(dayLabel)
        view.addSubview(openHourBtn)
        view.addSubview(openHourLabel)
        view.addSubview(closeHourBtn)
        view.addSubview(closeHourLabel)
        
        view.addSubview(confirmBtn)
        
        NSLayoutConstraint.activate([
            
            switchAvailable.topAnchor.constraint(equalTo: view.topAnchor , constant: (self.navigationController?.navigationBar.frame.height)! + 20.0),
            switchAvailable.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            
            dayLabel.topAnchor.constraint(equalTo: switchAvailable.bottomAnchor,constant: 20),
            dayLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            dayLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            dayLabel.heightAnchor.constraint(equalToConstant: 100),
            
            openHourBtn.topAnchor.constraint(equalTo: dayLabel.bottomAnchor,constant: 20),
            openHourBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            openHourBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            openHourBtn.heightAnchor.constraint(equalToConstant: 60),
            
            openHourLabel.topAnchor.constraint(equalTo: openHourBtn.topAnchor),
            openHourLabel.bottomAnchor.constraint(equalTo: openHourBtn.bottomAnchor),
            openHourLabel.centerXAnchor.constraint(equalTo: openHourBtn.centerXAnchor,constant: -80),
            
            
            closeHourBtn.topAnchor.constraint(equalTo: openHourBtn.bottomAnchor,constant: 20),
            closeHourBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            closeHourBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            closeHourBtn.heightAnchor.constraint(equalToConstant: 60),
            
            closeHourLabel.topAnchor.constraint(equalTo: closeHourBtn.topAnchor),
            closeHourLabel.bottomAnchor.constraint(equalTo: closeHourBtn.bottomAnchor),
            closeHourLabel.centerXAnchor.constraint(equalTo: closeHourBtn.centerXAnchor,constant: -80),
            
            confirmBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)! + 20.0),
            confirmBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            confirmBtn.widthAnchor.constraint(equalToConstant: 80),
            confirmBtn.heightAnchor.constraint(equalToConstant: 80),
            
        ])
        openHourBtn.addTarget(self, action: #selector(showPickerTime), for: .touchUpInside)
        closeHourBtn.addTarget(self, action: #selector(showPickerTime2), for: .touchUpInside)
        confirmBtn.addTarget(self, action: #selector(confimBtnAction), for: .touchUpInside)
    }
    
    //Picker
    @objc func showPickerTime(_sender : UIButton){
        
        view.addSubview(viewBlack)
        view.addSubview(hourPicker)
        view.addSubview(cancelPickerBtn)
        view.addSubview(confirmPickerBtn)
        
        NSLayoutConstraint.activate([
            viewBlack.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewBlack.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            hourPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
        confirmPickerBtn.addTarget(self, action: #selector(confirmPicker), for: .touchUpInside)
    }
    
    @objc func hidePickerTime(_sender : UIButton) {
        viewBlack.removeFromSuperview()
        hourPicker.removeFromSuperview()
        cancelPickerBtn.removeFromSuperview()
        confirmPickerBtn.removeFromSuperview()
    }
    
    @objc func confirmPicker(_sender : UIButton){
        viewBlack.removeFromSuperview()
        hourPicker.removeFromSuperview()
        cancelPickerBtn.removeFromSuperview()
        confirmPickerBtn.removeFromSuperview()
        
        let date = hourPicker.date
        let components = hourPicker.calendar.dateComponents([.hour,.minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        let dataHour = "\(String(hour)):\(String(format: "%02d", Int(minute)))"
        schedule?.hourStart = dataHour;
        
        openHourBtn.setTitle(dataHour, for: .normal)
    }
    
    
    //Picker
    @objc func showPickerTime2(_sender : UIButton){
        
        view.addSubview(viewBlack)
        view.addSubview(hourPicker2)
        view.addSubview(cancelPickerBtn)
        view.addSubview(confirmPickerBtn)
        
        NSLayoutConstraint.activate([
            viewBlack.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewBlack.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            hourPicker2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            hourPicker2.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            hourPicker2.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            hourPicker2.heightAnchor.constraint(equalToConstant: 200),
            
            cancelPickerBtn.topAnchor.constraint(equalTo: hourPicker2.bottomAnchor,constant: 20),
            cancelPickerBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40),
            cancelPickerBtn.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            cancelPickerBtn.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPickerBtn.topAnchor.constraint(equalTo: hourPicker2.bottomAnchor,constant: 20),
            confirmPickerBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40),
            confirmPickerBtn.widthAnchor.constraint(equalToConstant: view.frame.width/3),
            confirmPickerBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        cancelPickerBtn.addTarget(self, action: #selector(hidePickerTime2), for: .touchUpInside)
        confirmPickerBtn.addTarget(self, action: #selector(confirmPicker2), for: .touchUpInside)
    }
    
    @objc func hidePickerTime2(_sender : UIButton) {
        viewBlack.removeFromSuperview()
        hourPicker2.removeFromSuperview()
        cancelPickerBtn.removeFromSuperview()
        confirmPickerBtn.removeFromSuperview()
    }
    
    @objc func confirmPicker2(_sender : UIButton){
        viewBlack.removeFromSuperview()
        hourPicker2.removeFromSuperview()
        cancelPickerBtn.removeFromSuperview()
        confirmPickerBtn.removeFromSuperview()
        
        let date = hourPicker2.date
        let components = hourPicker2.calendar.dateComponents([.hour,.minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        
        let dataHour = "\(String(hour)):\(String(format: "%02d", Int(minute)))"
        schedule?.hourEnd = dataHour;
        closeHourBtn.setTitle(dataHour, for: .normal)
    }
    
    @objc func confimBtnAction(_sender : UIButton) {

        //add data in schedule and send
        schedule?.isAvailable = switchAvailable.isOn
        store?.schedule?[x] = schedule!;
        
        ServerHelper.shared.updateStoreSchedule(store: store!) { (getStore) in
            LocalHelper.shared.setClient(getStore)
            
        } failure: { (err) in
            print("Error ",err!)
        }
        self.reloadInputViews()
        self.navigationController?.popViewController(animated: true)
    }
    
}
