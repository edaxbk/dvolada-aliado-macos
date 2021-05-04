//
//  TripsOutController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TripsOutController : UIViewController, MKMapViewDelegate,UISearchBarDelegate{


    let locationBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.imageView?.tintColor = .white
        button.tintColor = .black
    return button
    }()
    
    let searchBtn : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.imageView?.tintColor = .white
        button.tintColor = .black
    return button
    }()
    

    let map : MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
       return mapView
    }()
    
    let confirmBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        btn.imageEdgeInsets.left = -50
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitle("Confirmar", for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    var searchBar : UISearchBar = {
        var search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = "Buscar Direccion asd"
        search.backgroundImage = UIImage()
        search.searchTextField.backgroundColor = .white
        return search
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tabBarItem.title = "Elige la direccion del cliente"
        
        map.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        //        let searchMap = MKLocalSearch()
        
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
      
        //checkLocationServices()

        //let initialLocation = CLLocation(latitude: (store.location?.latitude)!, longitude: (store.location?.longitude)!)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        
        //let rg = MKCoordinateRegion(center: initialLocation.coordinate,span: span)
        
        let anot = MKPointAnnotation()
        anot.title = "Nombre de la Store"
        //anot.coordinate = initialLocation.coordinate
        
        map.addAnnotation(anot)
        //map.setRegion(rg, animated: true)
        //map.setCenter(initialLocation.coordinate, animated: true)

        view.addSubview(map)
        view.addSubview(locationBtn)
        view.addSubview(searchBtn)
        view.addSubview(confirmBtn)
        view.addSubview(searchBar)
       
        NSLayoutConstraint.activate([
            
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor),
                
            searchBar.topAnchor.constraint(equalTo: map.topAnchor,constant: (navigationController?.navigationBar.frame.height)! + 20),
            searchBar.widthAnchor.constraint(equalToConstant: view.frame.width/2),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            locationBtn.bottomAnchor.constraint(equalTo: map.bottomAnchor,constant: -20),
            locationBtn.rightAnchor.constraint(equalTo: map.rightAnchor,constant: -20),
            locationBtn.widthAnchor.constraint(equalToConstant: 50),
            locationBtn.heightAnchor.constraint(equalToConstant: 50),
            
            searchBtn.bottomAnchor.constraint(equalTo: map.bottomAnchor,constant: -80),
            searchBtn.rightAnchor.constraint(equalTo: map.rightAnchor,constant: -20),
            searchBtn.widthAnchor.constraint(equalToConstant: 50),
            searchBtn.heightAnchor.constraint(equalToConstant: 50),
            
            confirmBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -200),
            confirmBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmBtn.widthAnchor.constraint(equalToConstant: 200),
            confirmBtn.heightAnchor.constraint(equalToConstant: 40),

        ])
        
        confirmBtn.addTarget(self, action: #selector(pushMenuStore), for: .touchUpInside)
        searchBtn.addTarget(self, action: #selector(PushSeacrhAction), for: .touchUpInside)
        locationBtn.addTarget(self, action: #selector(pushBtnSearch), for: .touchUpInside)
        
    }
   
    
    func updateLocationOnMap(to location: CLLocation, with title: String?) {
        
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
                
        self.map.removeAnnotations(self.map.annotations)
        self.map.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
        self.map.setRegion(viewRegion, animated: true)
    }
    @objc func PushSeacrhAction() {
        print("Estyo en search")
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        
    }

        
    @objc func pushBtnSearch() {
        
        print("Button Map")
        updateLocationOnMap (to: locationManager.location! , with: "Enviar")
    }
    
    @objc func pushMenuStore() {
        
        let menuStoreCollection = MenuStoreController(collectionViewLayout: UICollectionViewFlowLayout())
        //menuStoreCollection.menus = menus
        navigationController?.pushViewController(menuStoreCollection, animated: true)
     }
    /*
    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Mostrar alerta
      }
    }
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            map.showsUserLocation = true
        case .denied: // Mostrar alerta
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            map.showsUserLocation = true
        case .restricted: // Mostrar alerta
            break
        case .authorizedAlways:
            break
      default:
        break
        }
    }*/
    
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let coordinates = mapView.centerCoordinate
        return CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
 //Para el search del mapkit
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("********Estoy en clicked search")
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = searchBar.text

        print("Text:",searchBar.text)
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        print("Voy a start")
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            
//            UIApplication.shared.endIgnoringInteractionEvents()
            
            print("Response:",response)
            
            if response == nil{
                print("Error",error!)
            }//if
            else{
                
//                let anotations = self.map.annotations
//                self.map.removeAnnotation(anotations as! MKAnnotation)
                
                let latitude = response!.boundingRegion.center.latitude
                let longitude = response!.boundingRegion.center.longitude
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                self.map.addAnnotation(annotation)
            }//else
            
        }//start
    }//func
}


extension TripsOutController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
}

extension CLLocation {
    

    
    func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
        print("Llego aqui***********-----")
        let geocoder = CLGeocoder()
            
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                handler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                handler(nil)
            }
        }
    }
    
    func lookUpLocationName(_ handler: @escaping (String?) -> Void) {
        
        lookUpPlaceMark { (placemark) in
        
            handler(placemark?.description)
        }
    }
    
    
    
    
    
}

