//
//  MapController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 01/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class MapController: UIViewController , GMSMapViewDelegate{
    
    
    var mapView : GMSMapView?
    var locationUser : GMSMarker?
    var direction = Direction()
    
    var listener : DirectionsListener?
    
    
    let imageMarker : UIImageView = {
        
        let image = UIImageView(image: #imageLiteral(resourceName: "marker"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image;
        
    }()
    
    
    var confirmDireccion : UIButton =  {
        
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.94, green: 0.42, blue: 0.00, alpha: 1.00)
        view.setTitle("Confirmar Dirección", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 20
        view.titleLabel?.font = UIFont(name: "Manrope-Regular", size: 14)
        view.addTarget(self, action: #selector(handleConfirmDirection), for: .touchUpInside)
        return view
    }()
    
    @objc func handleConfirmDirection () {
        
        print("HANDLE OK DIRECCTIONRR")
        
        let variable = direction.coordinates?.latitude
        let menuStoreCollection = MenuStoreController(collectionViewLayout: UICollectionViewFlowLayout())
        
        menuStoreCollection.listener = listener
        menuStoreCollection.direction = direction

        self.navigationController?.pushViewController(menuStoreCollection, animated: true)
        print(" CORIDNATES :: ", variable)
     /*
        let controller = ConfirmDirectionController()
        controller.listener = listener
        controller.direction = direction
    
        self.navigationController?.pushViewController(controller, animated: true)
       */
    }
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
     
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        button.tintColor = .black
        button.addTarget(self, action: #selector(onExitClick), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        mapView = createMapView()
        loadMap()
    
    }
    
    
    func createMapView ()-> GMSMapView{
        let map = GMSMapView();
        map.translatesAutoresizingMaskIntoConstraints = false
       
        return map;
    }
    
    
    func loadMap(){
        if let mapView = mapView {
            self.view.addSubview(mapView);
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true;
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true;
            mapView.addSubview(imageMarker)
            imageMarker.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true;
            imageMarker.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true;
            imageMarker.heightAnchor.constraint(equalToConstant: 40).isActive = true;
            mapView.delegate = self
            
            
            /*
            let camera = GMSCameraPosition.camera(withLatitude: (direction?.coordinates!.latitude)!,
                                                  longitude: (direction?.coordinates!.longitude)!,
                                                  zoom: 20)
            */
            let locationStore = LocalHelper.shared.getClient()?.location
            let camera = GMSCameraPosition.camera(withLatitude: (locationStore?.latitude )!,
                                                  longitude: ( locationStore?.longitude)!,
                                                  zoom: 20)
            mapView.camera = camera
                 
            
            view.addSubview(confirmDireccion)
            NSLayoutConstraint.activate([
                confirmDireccion.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant : -10),
                confirmDireccion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant : 20),
                confirmDireccion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant : -20),
                confirmDireccion.heightAnchor.constraint(equalToConstant: 60),
            ])
            
        }
    }
    
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let coordinate = mapView.projection.coordinate(for: imageMarker.center)
        direction.coordinates = LatLng(latitude: coordinate.latitude , longitude: coordinate.longitude)
    }

    @objc func onExitClick (){
        dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
}
