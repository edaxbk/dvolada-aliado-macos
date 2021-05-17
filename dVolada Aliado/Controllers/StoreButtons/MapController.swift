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
    
    var direction = Direction()
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?

    var locationVar : LatLng?
    
    let imageMarker : UIImageView = {
        
        let image = UIImageView(image: #imageLiteral(resourceName: "marker"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image;
        
    }()
    
    let searchBtn : UIButton = {
        let button =  UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        button.backgroundColor = UIColor(red: 0.94, green: 0.42, blue: 0.00, alpha: 1.00)
        button.layer.cornerRadius = 10
        button.tintColor = .white
    return button
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
        ServerHelper.shared.findAddress(latitude: (direction.coordinates!.latitude)!, longitude: direction.coordinates!.longitude!) { (direction) in

            self.direction.direction = direction.direction
            let menuStoreCollection = MenuStoreController()
            menuStoreCollection.direction = direction
            self.navigationController?.pushViewController(menuStoreCollection, animated: true)
        }
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
        
        view.addSubview(searchBtn)

        NSLayoutConstraint.activate([
            searchBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -150),
            searchBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            searchBtn.widthAnchor.constraint(equalToConstant: 50),
            searchBtn.heightAnchor.constraint(equalToConstant: 50),
        ])

        searchBtn.addTarget(self, action: #selector(PushSeacrhAction), for: .touchUpInside)
        
        
    }
    
    @objc func PushSeacrhAction() {
        loadSearchControoler()
    }
    
    
    func createMapView ()-> GMSMapView{
        let map = GMSMapView();
        map.translatesAutoresizingMaskIntoConstraints = false
        return map;
    }
    
    func loadSearchControoler() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        searchController?.searchBar.barTintColor = .orange
        searchController?.searchBar.placeholder =  "Buscar una dirección"
        searchController?.searchBar.layer.backgroundColor = UIColor.red.cgColor
        searchController?.searchBar.searchTextField.backgroundColor = .white
        searchController?.searchBar.searchTextField.textColor =  .black
        searchController?.searchBar.tintColor = .white
        
        let subView = UIView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 45.0))

        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        
       
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
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
            
            let locationStore = locationVar
            
            let camera = GMSCameraPosition.camera(withLatitude: (locationStore?.latitude)!,
                                                  longitude: (locationStore?.longitude)!,
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
    }
}


// Handle the user's selection.
extension MapController: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    locationVar = LatLng(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
    self.viewDidLoad()
  }

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
