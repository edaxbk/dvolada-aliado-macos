//
//  StoreController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 17/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation

class StoreController : UIViewController {
    
    var seting:String?
    
    var store : Store? {
        didSet {
            
            if let url = store?.banner {
                bgImage.loadImage(url: url)
            }
            if let urlLogo = store?.url_logo {
                logo.loadImage(url: urlLogo)
            }
            if let trip = store?.counter{
                tripsLabel.text = String(trip)
            }
            if let dateString = store?.date_subscription {
                dateLabel.text = dateString
            }
        }
    }
    
    var blackView : UIView = {
        let vista = UIView()
        vista.translatesAutoresizingMaskIntoConstraints = false
        vista.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return vista
    }()
    
    var menuBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.tintColor = .white
        return button
    }()
    var backToScreenBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var bgImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        image.clipsToBounds = true
        return image
    }()
    
    let scheduleBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "calendar"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .white
        return btn
    }()
    
    let dishBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "square.split.2x2.fill"), for: .normal)
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        
        btn.tintColor = .white
        return btn
    }()
    
    let tripsBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .white
        return btn
    }()
    
    let uploadVideoBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "video.fill"), for: .normal)
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.tintColor = .white
        return btn
    }()
    
    
    var logo : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        
        return image
    }()
    
    let calflabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5.0"
        label.font = label.font.withSize(18)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 25
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        return label
    }()
    
    let tripsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = label.font.withSize(18)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    let tripsText : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Viajes Restantes"
        label.font = label.font.withSize(15)
        label.textAlignment = .center
        label.textColor = .black
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        return label
    }()
    let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No disponible"
        label.font = label.font.withSize(18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var dateText : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fecha de Vencimiento"
        label.font = label.font.withSize(15)
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    let closeSessionBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cerrar Session", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 15
        btn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        btn.tintColor = .white
        btn.imageEdgeInsets.left = -100
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return btn
    }()
    //Lineas Grises
    let lineBottonH: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    let lineBottonV: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(bgImage)
        view.addSubview(blackView)
        view.addSubview(logo)
        view.addSubview(calflabel)
        view.addSubview(tripsLabel)
        view.addSubview(tripsText)
        view.addSubview(dateLabel)
        view.addSubview(dateText)
        view.addSubview(lineBottonV)
        view.addSubview(lineBottonH)
        view.addSubview(closeSessionBtn)
        view.addSubview(menuBtn)
        view.addSubview(backToScreenBtn)
        
        NSLayoutConstraint.activate([
            
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            bgImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            bgImage.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            
            blackView.topAnchor.constraint(equalTo: view.topAnchor),
            blackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            blackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            blackView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: bgImage.centerYAnchor),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),
            
            calflabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calflabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: -30),
            calflabel.heightAnchor.constraint(equalToConstant: 60),
            calflabel.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            tripsLabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor),
            tripsLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            tripsLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            tripsLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 8),
            
            tripsText.bottomAnchor.constraint(equalTo: tripsLabel.bottomAnchor,constant: -5),
            tripsText.leftAnchor.constraint(equalTo: view.leftAnchor),
            tripsText.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            tripsText.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            
            dateLabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            dateLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 8),
            
            dateText.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: -5),
            dateText.rightAnchor.constraint(equalTo: view.rightAnchor),
            dateText.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            dateText.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            
            lineBottonV.bottomAnchor.constraint(equalTo: tripsLabel.bottomAnchor),
            lineBottonV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineBottonV.widthAnchor.constraint(equalToConstant: 1),
            lineBottonV.heightAnchor.constraint(equalToConstant: view.frame.height / 14 ),
            
            lineBottonH.bottomAnchor.constraint(equalTo: tripsLabel.bottomAnchor),
            lineBottonH.leftAnchor.constraint(equalTo: view.leftAnchor),
            lineBottonH.rightAnchor.constraint(equalTo: view.rightAnchor),
            lineBottonH.heightAnchor.constraint(equalToConstant: 1),
            
            closeSessionBtn.topAnchor.constraint(equalTo: tripsLabel.bottomAnchor,constant: 20),
            closeSessionBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            closeSessionBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            closeSessionBtn.heightAnchor.constraint(equalToConstant: view.frame.height / 12),
            
            menuBtn.topAnchor.constraint(equalTo: view.topAnchor,constant: 20),
            menuBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            menuBtn.widthAnchor.constraint(equalToConstant: 50),
            menuBtn.heightAnchor.constraint(equalToConstant: 50),
            
            backToScreenBtn.topAnchor.constraint(equalTo: view.topAnchor,constant: 20),
            backToScreenBtn.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            backToScreenBtn.widthAnchor.constraint(equalToConstant: 50),
            backToScreenBtn.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        closeSessionBtn.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        menuBtn.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        backToScreenBtn.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
        closeSessionBtn.addTarget(self, action: #selector(closeSession), for: .touchUpInside)
    }
    
    
    @objc func handleDismissView() {
        print("dismiss")
        dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func closeSession() {
        LocalHelper.shared.setClient(nil)
        let loginController = LoginController()
        let loginNavigationController = UINavigationController(rootViewController: loginController)
        loginNavigationController.modalPresentationStyle = .fullScreen
        loginNavigationController.navigationBar.isHidden = true
        self.present(loginNavigationController, animated: true, completion: nil)
    }
    func showControllerForSetting(setting: Setting) {
        
        seting = setting.name.rawValue
        
        switch setting.name {
        case .schedules:
            openScheduleStoreCollection()
        case .dishes:
            openDishStoreCollection()
        case .trips:
            openTripsOutCollection()
        case .estadistics:
            openstatisticsController()
        case .dvolada:
            openUploadVideoOutCollection()
        default:
            print("No selecciono nada")
        }
    }
    
    func openScheduleStoreCollection() {
        
        let scheduleController = ScheduleStoreCollection(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: scheduleController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.backgroundColor = .orange
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor =  .black
        scheduleController.title = self.seting
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    @objc func openDishStoreCollection() {
        
        let menuController = MenuStoreTableView()
        let menunavigationController = UINavigationController(rootViewController: menuController)
        menunavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        menunavigationController.navigationBar.backgroundColor = .orange
        menunavigationController.navigationBar.isTranslucent = true
        menunavigationController.navigationBar.tintColor = .black
        menuController.title = self.seting
        self.present(menunavigationController, animated: true, completion: nil)
    }
     
    @objc func openTripsOutCollection() {
        
        
        let tripsController = MapController()
        tripsController.locationVar = store?.location
        let tnavigationController = UINavigationController(rootViewController: tripsController)
        tnavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        tnavigationController.navigationBar.backgroundColor = .orange
        tnavigationController.navigationBar.isTranslucent = true
        tnavigationController.navigationBar.tintColor = .black
        tripsController.title = seting
        self.present(tnavigationController, animated: true, completion: nil)
         
    }
    
    @objc func openstatisticsController() {
        
        let statisticsController = StatisticsController()
        let snavigationController = UINavigationController(rootViewController: statisticsController)
        snavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        snavigationController.navigationBar.backgroundColor = .orange
        snavigationController.navigationBar.isTranslucent = true
        snavigationController.navigationBar.tintColor = .black
        
        statisticsController.title = seting
        self.present(snavigationController, animated: true, completion: nil)
    }
    
    @objc func openUploadVideoOutCollection() {
        
        let uploadVideoController = UploadVideoController(collectionViewLayout: UICollectionViewFlowLayout())
        let unavigationController = UINavigationController(rootViewController: uploadVideoController)
        unavigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        unavigationController.navigationBar.backgroundColor = UIColor.primaryColor
        unavigationController.navigationBar.isTranslucent = true
        unavigationController.navigationBar.tintColor = .black
        
        uploadVideoController.title = seting
        self.present(unavigationController, animated: true, completion: nil)
    }
}
