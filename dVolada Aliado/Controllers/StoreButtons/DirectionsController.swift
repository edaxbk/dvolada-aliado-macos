//
//  DirectionsController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 01/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation



var identifierDirection = "identifierDirection"

class DirectionsController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, GMSAutocompleteViewControllerDelegate, DirectionsListener {
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("PLACE RAW VALUE \(place.coordinate)")
    
        let item = Direction()
        
        item.direction = place.formattedAddress!
        item.label = place.name
        
        let latitude = place.coordinate.latitude
        let longitude = place.coordinate.longitude
        
        item.coordinates = LatLng(latitude: latitude, longitude: longitude)
        //self.hideKeyboard()
        
        
        let mapController = MapController()
        mapController.direction = item
        mapController.listener = self
        self.navigationController?.pushViewController(mapController, animated: true)
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
        
    var directionsCollectionView : UICollectionView!
    
    var locationManager = CLLocationManager()
    
    var listDirections = Array<Direction>()
    
    var originDirection : Direction?

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        updateLocation(location: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        locationManager.stopUpdatingLocation()
    }
    
    func updateLocation(location : CLLocationCoordinate2D){
        
        
        ServerHelper.shared.findAddress(latitude: location.latitude, longitude: location.longitude) { (direction) in
            
            self.userLocationContainer.isHidden = false
            // self.userLocationContainer.visibility = .visible
            self.directionTextView.text = direction.direction
                     
            self.originDirection = direction
            
        }
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    func onDirectionSaved(direction: Direction) {
        print("NEW DIRECTION ADDDED")
        
        listDirections.append(direction)
        DispatchQueue.main.async {
            
            if(self.directionsCollectionView == nil){
                self.emptyPlaceHolder.visibility = .gone
                self.initListDirection()
            }
            
            
            
            if(self.directionsCollectionView != nil){
                self.directionsCollectionView.reloadData()
            }
            
            
        }
    }
    
    
    var isCancelButtonHidden : Bool? {
        didSet {
            cancelButton.isHidden = isCancelButtonHidden!
            self.view.layoutIfNeeded()
        }
    }
    
    let cancelButton : UIButton = {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "icons8-delete-50"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        
        
        return button
        
    }()
    
    
    @objc func handleExit(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    var emptyImageDirectionContainer : UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        //image.image = #imageLiteral(resourceName: "direction_banner")
        
        return image
    }()
    
    
    var emptyPlaceHolder : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isHidden = true
        
        return view
    }()
    
    var userLocationContainer : UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isHidden = true
        
        return view
    }()
    
     var searchImage : UIImageView = {
         
         let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         image.contentMode = .scaleAspectFit
         image.backgroundColor = .clear
         image.image = #imageLiteral(resourceName: "icons8-search-50")
         
         return image
     }()
     
    
    let inputContainer : UIView = {
        
        let view = UIView ()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        view.layer.cornerRadius = 15
        
        return view
    }()
       
    
    var titleTextView : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.textColor = .black
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .center
        text.text = "¿Dónde quieres \n recibir tu pedido?"
        text.font = UIFont(name: "Manrope-Regular", size: 18)
        text.sizeToFit()
        text.isUserInteractionEnabled = false
        text.isScrollEnabled = false
        return text
    }()
    
    
    var placeHolderTextView : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.00)
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .left
        text.text = "Buscar dirección y numero"
        text.font = UIFont(name: "Manrope-Regular", size: 12)
        text.sizeToFit()
        text.isUserInteractionEnabled = false
        text.isScrollEnabled = false
        return text
    }()
    
    
    var useMyLocation : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = .black
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .left
        text.text = "Usar mi ubicación"
        text.font = UIFont(name: "Manrope-SemiBold", size: 14)
        text.sizeToFit()
        text.isUserInteractionEnabled = false
        text.isScrollEnabled = false
        return text
    }()
    
    
    var emtpyLocationsTitle : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = .black
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .center
        text.text = "Aun no tienes direcciones guardadas"
        text.font = UIFont(name: "Manrope-SemiBold", size: 14)
        text.sizeToFit()
        text.isUserInteractionEnabled = false
        text.isScrollEnabled = false
        return text
    }()
    
    var emtpyLocationsDescription : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.00)
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .center
        text.text = "Utiliza la busquedad para encontrar una dirección"
        text.font = UIFont(name: "Manrope-Regular", size: 12)
        text.sizeToFit()
        text.isUserInteractionEnabled = false
        text.isScrollEnabled = false
        return text
    }()
    
    
    
    
    var directionTextView : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.00)
        text.isEditable = false
        text.isSelectable = false
        text.textAlignment = .left
        text.font = UIFont(name: "Manrope-Regular", size: 12)
        text.sizeToFit()
        text.isUserInteractionEnabled = false
        text.isScrollEnabled = false
        return text
    }()
    
    
    
    
    
    var imageLocation  : UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        image.image = #imageLiteral(resourceName: "icons8-location-off-50")
        image.tintColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1.00)
        
        return image
    }()
    
    
    
    var placesClient : GMSPlacesClient!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //collectionView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        
        view.addSubview(emptyImageDirectionContainer)
        view.addSubview(titleTextView)
        view.addSubview(inputContainer)
        view.addSubview(userLocationContainer)
        view.addSubview(emptyPlaceHolder)
        
        
        NSLayoutConstraint.activate([
        
            emptyImageDirectionContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            emptyImageDirectionContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyImageDirectionContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            emptyImageDirectionContainer.heightAnchor.constraint(equalToConstant: 250),
            
            titleTextView.topAnchor.constraint(equalTo: emptyImageDirectionContainer.bottomAnchor , constant : -20),
            titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            
            inputContainer.topAnchor.constraint(equalTo: titleTextView.bottomAnchor , constant : 10),
            inputContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            inputContainer.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -20),
            inputContainer.heightAnchor.constraint(equalToConstant: 50),
            
            
            userLocationContainer.topAnchor.constraint(equalTo: inputContainer.bottomAnchor , constant: 10),
            userLocationContainer.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            userLocationContainer.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -20),
            userLocationContainer.heightAnchor.constraint(equalToConstant: 90),
            
            
            emptyPlaceHolder.topAnchor.constraint(equalTo: userLocationContainer.bottomAnchor, constant: 40),
            emptyPlaceHolder.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 20),
            emptyPlaceHolder.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -20),
            emptyPlaceHolder.heightAnchor.constraint(equalToConstant: 90),
            
            
            
        ])
        
        inputContainer.addSubview(searchImage)
        inputContainer.addSubview(placeHolderTextView)
        
        NSLayoutConstraint.activate([

            searchImage.leftAnchor.constraint(equalTo: inputContainer.leftAnchor , constant: 20),
            searchImage.widthAnchor.constraint(equalToConstant: 20),
            searchImage.heightAnchor.constraint(equalToConstant: 20),
            searchImage.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            
            placeHolderTextView.leftAnchor.constraint(equalTo: searchImage.rightAnchor, constant: 10),
            placeHolderTextView.rightAnchor.constraint(equalTo: inputContainer.rightAnchor, constant: -10),
            placeHolderTextView.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            
            
        ])
        
        
        
        userLocationContainer.addSubview(imageLocation)
        userLocationContainer.addSubview(useMyLocation)
        userLocationContainer.addSubview(directionTextView)
        
        NSLayoutConstraint.activate([
            
            imageLocation.leftAnchor.constraint(equalTo: userLocationContainer.leftAnchor , constant: 20),
            imageLocation.widthAnchor.constraint(equalToConstant: 20),
            imageLocation.heightAnchor.constraint(equalToConstant: 20),
            imageLocation.centerYAnchor.constraint(equalTo: userLocationContainer.centerYAnchor),
            
            
            useMyLocation.topAnchor.constraint(equalTo: userLocationContainer.topAnchor , constant: 10),
            useMyLocation.leftAnchor.constraint(equalTo: imageLocation.rightAnchor, constant: 10),
            useMyLocation.rightAnchor.constraint(equalTo: userLocationContainer.rightAnchor, constant: -10),
            
            
            directionTextView.topAnchor.constraint(equalTo: useMyLocation.bottomAnchor , constant: -15),
            directionTextView.leftAnchor.constraint(equalTo: imageLocation.rightAnchor, constant: 10),
            directionTextView.rightAnchor.constraint(equalTo: userLocationContainer.rightAnchor, constant: -10),
        ])
               
        
        emptyPlaceHolder.addSubview(emtpyLocationsTitle)
        emptyPlaceHolder.addSubview(emtpyLocationsDescription)
        
        
        NSLayoutConstraint.activate([
        
            emtpyLocationsTitle.leftAnchor.constraint(equalTo: emptyPlaceHolder.leftAnchor, constant: 10),
            emtpyLocationsTitle.rightAnchor.constraint(equalTo: emptyPlaceHolder.rightAnchor, constant: -10),
            emtpyLocationsTitle.centerYAnchor.constraint(equalTo: emptyPlaceHolder.centerYAnchor),
            
            emtpyLocationsDescription.topAnchor.constraint(equalTo: emtpyLocationsTitle.bottomAnchor , constant: -10),
            emtpyLocationsDescription.leftAnchor.constraint(equalTo: emptyPlaceHolder.leftAnchor, constant: 10),
            emtpyLocationsDescription.rightAnchor.constraint(equalTo: emptyPlaceHolder.rightAnchor, constant: -10),
            
            
        ])
        
        
        
        
        
        

//

        
        
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
        
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30)
            
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDirectionInsertView))
        inputContainer.addGestureRecognizer(tap)
        
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(handleOwnLocation))
        userLocationContainer.addGestureRecognizer(tap2)
        
        
        
        loadLocation()
        
        
        
        let client = LocalHelper.shared.getClient()

        if(client != nil){

            if(client!._id != nil){

                ServerHelper.shared.getDirections(clientId: client!._id!) { (list) in

                    self.listDirections.append(contentsOf: list)
                    
                    if(list.isEmpty){
                        self.emptyPlaceHolder.visibility = .visible
                    }else{
                        self.emptyPlaceHolder.visibility = .gone
                        self.initListDirection()
                    }
                    

                    DispatchQueue.main.async {
                        if(self.directionsCollectionView != nil){
                            self.directionsCollectionView.reloadData()
                        }
                    }
                }
            }
        }
        
       
    }
    
    func initListDirection(){
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        directionsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        directionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        directionsCollectionView.register(DirectionItemCell.self, forCellWithReuseIdentifier: identifierDirection)
        directionsCollectionView.delegate = self
        directionsCollectionView.dataSource = self
        directionsCollectionView.isScrollEnabled = true
        directionsCollectionView.backgroundColor = .white
        
        
        view.addSubview(directionsCollectionView)
        
        
        NSLayoutConstraint.activate([
            directionsCollectionView.topAnchor.constraint(equalTo: userLocationContainer.bottomAnchor, constant: 20),
            directionsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            directionsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            directionsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc func handleOwnLocation () {
        allowAccess(direction: originDirection!)
    }
    
    
    func loadLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    @objc func handleDirectionInsertView(gesture: UITapGestureRecognizer) -> Void {
        
        
        //let searchController = SearchDirectionController()
        //searchController.listener = self
        //self.navigationController?.pushViewController(searchController, animated: true)
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        
        // Specify the place data types to return.
        let fields: GMSPlaceField =
            
            GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue)
                | UInt(GMSPlaceField.name.rawValue)
                | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    

    @objc func onExitClick(){
        navigationController?.popViewController(animated: true)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    

   
    
    
    func allowAccess(direction : Direction){
        
        let client = LocalHelper.shared.getClient()
        //client?.directionToSend = direction
        
        
        LocalHelper.shared.setClient(client)
        
        print("ALLOW ACCESS")
        /*
        let tabController = TabController()
        let nav = UINavigationController(rootViewController: tabController)
        nav.modalPresentationStyle = .fullScreen
        navigationController?.present(nav, animated: true, completion: nil)*/
    }
   
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDirections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: identifierDirection, for: indexPath) as! DirectionItemCell
        
        cellA.direction = listDirections[indexPath.item]
        return cellA
    }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width , height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let direction = listDirections[indexPath.item]
        allowAccess(direction: direction)
    }
}

extension UIView {

    enum Visibility: String {
        case visible = "visible"
        case invisible = "invisible"
        case gone = "gone"
    }

    var visibility: Visibility {
        get {
            let constraint = (self.constraints.filter{$0.firstAttribute == .height && $0.constant == 0}.first)
            if let constraint = constraint, constraint.isActive {
                return .gone
            } else {
                return self.isHidden ? .invisible : .visible
            }
        }
        set {
            if self.visibility != newValue {
                self.setVisibility(newValue)
            }
        }
    }

    @IBInspectable
    var visibilityState: String {
        get {
            return self.visibility.rawValue
        }
        set {
            let _visibility = Visibility(rawValue: newValue)!
            self.visibility = _visibility
        }
    }

    private func setVisibility(_ visibility: Visibility) {
        let constraints = self.constraints.filter({$0.firstAttribute == .height && $0.constant == 0 && $0.secondItem == nil && ($0.firstItem as? UIView) == self})
        let constraint = (constraints.first)

        switch visibility {
        case .visible:
            constraint?.isActive = false
            self.isHidden = false
            break
        case .invisible:
            constraint?.isActive = false
            self.isHidden = true
            break
        case .gone:
            self.isHidden = true
            if let constraint = constraint {
                constraint.isActive = true
            } else {
                let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 0)
                // constraint.priority = UILayoutPriority(rawValue: 999)
                self.addConstraint(constraint)
                constraint.isActive = true
            }
            self.setNeedsLayout()
            self.setNeedsUpdateConstraints()
        }
    }
}
