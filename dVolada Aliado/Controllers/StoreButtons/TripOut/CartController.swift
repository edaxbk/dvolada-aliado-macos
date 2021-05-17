//
//  CartController.swift
//  dVolada Aliado/Users/miguelledezma/Desktop/Dvolada-Primary-Server
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView
import SCLAlertView


class CartController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ClientDataListener {
    
    func onClientSaved(client: Client) {
        self.client = client
        collectionView.reloadData()
    }
    
    var headerDirectionCellID = "headerDirectionCellID"
    var cartListCellID = "cartListCellID"
    var paymentMethodCellID = "paymentMethodCellID"
    var cuponInsertCellID = "cuponInsertCellID"
    var typeDeliveryCellID = "typeDeliveryCellID"
    var emptyCellID = "emptyCellID"
    var clientDataID = "clientDataID"
    
    var listener : GeneralCartListener?
    var listener2 : TransactionListener?
    var subTotal = 0
    var fee : Int?
    var priceFeeObject : PriceFee?
    var extraFee = 0
    
    var direction : Direction?
    var client : Client?
    var list = Array<Cart>() {
        didSet {
           updateCartPrice()
           collectionView.reloadData()
        }
    }
    
    
    var indicatorView : NVActivityIndicatorView = {
        let indicatorView = NVActivityIndicatorView(frame: CGRect.zero, type: .ballBeat, color: .orange, padding: nil)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    
    var blackLoadingLayer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        view.isHidden = true
        return view
    }()
    
    var store : Store? {
        didSet {
            collectionView.reloadData()
            
           
            let origin = LatLng(latitude: (self.store?.location!.latitude)!, longitude: (self.store?.location!.longitude)!)
            let destination = LatLng(latitude: (self.direction?.coordinates?.latitude)! , longitude: (self.direction?.coordinates?.longitude )!)
            let state = LocalHelper.shared.getClient()?.state
            
            
            ServerHelper.shared.getFeeCost(locationStore: origin, destination: destination, state: state!) { (priceFee) in
                
                self.priceFeeObject = priceFee
                self.fee = Int(priceFee.price!)
                self.extraFee = Int(priceFee.extraFee!)
                self.blackLoadingLayer.isHidden = true
                self.indicatorView.isHidden = true
                self.view.layoutIfNeeded()
                self.indicatorView.stopAnimating()
                self.collectionView.reloadData()
            }
            
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            FirebaseAPI.shared.getSettings { (settings) in
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    func updateCartPrice(){
        subTotal = 0
        list.forEach { (cart) in
            subTotal += cart.dish!.price! * cart.quantity!
        }
    }
    
    var exitButton : UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "icons8-back-64")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return button
    }()
    
    @objc func handleExit() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1.00)
        
        if #available(iOS 11.0, *) {
            if let top = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                collectionView.contentInset = UIEdgeInsets(top: -top, left: 0, bottom: 0, right: 0)
            }
        } else {
            collectionView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
        
        registerCells()
        
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 80),
            exitButton.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        
        view.addSubview(confirmOrderButton)
        
        NSLayoutConstraint.activate([
            confirmOrderButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            confirmOrderButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            confirmOrderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            confirmOrderButton.heightAnchor.constraint(equalToConstant: 65)
            
        ])
        
        
        confirmOrderButton.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
           
        view.addSubview(blackLoadingLayer)
        view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            blackLoadingLayer.topAnchor.constraint(equalTo: view.topAnchor),
            blackLoadingLayer.leftAnchor.constraint(equalTo: view.leftAnchor),
            blackLoadingLayer.rightAnchor.constraint(equalTo: view.rightAnchor),
            blackLoadingLayer.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 50),
            indicatorView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        blackLoadingLayer.isHidden = false
        indicatorView.isHidden = false
        view.layoutIfNeeded()
        indicatorView.startAnimating()
    }
    func showErrorMessage(_ message : String){
        SCLAlertView().showError("Error", subTitle: message) // Error
    }
    
    let confirmOrderButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Realizar Compra", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(onCreateOrder), for: .touchUpInside)
        return button
    }()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func registerCells () {
        collectionView.register(HeaderDirectionCell.self, forCellWithReuseIdentifier: headerDirectionCellID)
        collectionView.register(ClientDataCell.self, forCellWithReuseIdentifier: clientDataID)
        collectionView.register(CartListCell.self, forCellWithReuseIdentifier: cartListCellID)
        collectionView.register(PaymentMethodCell.self, forCellWithReuseIdentifier: paymentMethodCellID)
        collectionView.register(CuponInsertCell.self, forCellWithReuseIdentifier: cuponInsertCellID)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: emptyCellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.item == 0){
            let headerDirectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: headerDirectionCellID, for: indexPath) as! HeaderDirectionCell
            headerDirectionCell.direction = direction
            return headerDirectionCell
            
        }else if(indexPath.item == 1){
            let clienDataCell = collectionView.dequeueReusableCell(withReuseIdentifier: clientDataID, for: indexPath) as! ClientDataCell
            
            if((client) != nil){
                clienDataCell.titlePaymentLabel.text = "Cliente   " + (client?.complete_name)!

                clienDataCell.nameclientLabel.text = "Telefono   " + (client?.phone_number)!
                clienDataCell.nameclientLabel.textColor = .black
            }
            clienDataCell.addDataclientButton.addTarget(self, action: #selector(handleAddClienData), for: .touchUpInside)
            return clienDataCell
        }else if(indexPath.item == 2){
            let cartListCell = collectionView.dequeueReusableCell(withReuseIdentifier: cartListCellID, for: indexPath) as! CartListCell
            cartListCell.store = store
            cartListCell.list = list
            cartListCell.subTotal = subTotal
            cartListCell.extraFee = extraFee
            if let finalFee = fee {
                cartListCell.fee = finalFee
            }
            return cartListCell
        }else if(indexPath.item == 3){
            let paymentMethodCell = collectionView.dequeueReusableCell(withReuseIdentifier: paymentMethodCellID, for: indexPath) as! PaymentMethodCell
            return paymentMethodCell
        }else if(indexPath.item == 4){
            let cuponInsertCell = collectionView.dequeueReusableCell(withReuseIdentifier: cuponInsertCellID, for: indexPath) as! CuponInsertCell
            cuponInsertCell.editButton.addTarget(self, action: #selector(handleCuponPayment), for: .touchUpInside)
            return cuponInsertCell
        }else if(indexPath.item == 5){
            let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellID, for: indexPath) as! EmptyCell
            return emptyCell
        }
        
        
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: headerDirectionCellID, for: indexPath) as! HeaderDirectionCell
        return defaultCell
    }
    @objc func handleAddClienData (){
        let controller = WriteDataClient()

        if((client) != nil){
            controller.phoneComplementLabel.text = client?.complete_name
            controller.phoneComplementLabel.text = client?.phone_number
        }
        
        controller.listener = self
        controller.modalPresentationStyle = .fullScreen
        navigationController?.present(controller, animated: true, completion: nil)
    }
        
    
    @objc func handleCuponPayment(){
        
        let controller = WriteCuponController()
        controller.modalPresentationStyle = .fullScreen
        navigationController?.present(controller, animated: true, completion: nil)
    }
        
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(indexPath.item == 0){
            return CGSize(width: view.frame.width, height: 190)
        } else if(indexPath.item == 1){
            return CGSize(width: view.frame.width, height: 160)
        }else if(indexPath.item == 2){
            let totalHeightSubTotal = 50
            let productsHeight = (list.count * HEIGHT_DISH_HORIZONTAL) + 150 + totalHeightSubTotal
            return CGSize(width: view.frame.width, height: CGFloat(productsHeight))
        }else if(indexPath.item == 3){
            return CGSize(width: view.frame.width, height: 140)
        }else if(indexPath.item == 4){
            return CGSize(width: view.frame.width, height: 140)
        }else if(indexPath.item == 5){
            return CGSize(width: view.frame.width, height: 140)
        }else if(indexPath.item == 6){
            return CGSize(width: view.frame.width, height: 100)
        }
        
        return CGSize(width: view.frame.width, height: 300)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated:true)
    }
    
    @objc func onCreateOrder(){
        if(!list.isEmpty){
                
                if let feeFinal = fee {
                    
                    if((client) == nil){
                        showErrorMessage("Agregue datos del cliente")
                        return
                    }
                    
                    let transaction = Order()
                    let paymentCharge = PaymentCharge()
                    paymentCharge.total = Double((feeFinal + subTotal))
                    paymentCharge.subTotal = Double(subTotal)
                    paymentCharge.fee = Double(feeFinal)
                    paymentCharge.typeOfPayment = "CASH"
                    paymentCharge.priceFee = priceFeeObject
                    
                    let today = Date()
                    let formatter = DateFormatter()
                    formatter.dateStyle = .long
                    formatter.locale = .init(identifier: "es_ES")
                    
                    transaction.client = client
                    transaction.cart = list
                    transaction.date_mobile = formatter.string(from: today)
                    transaction.direction_destination = direction?.direction
                    transaction.destination = direction?.coordinates
                    transaction.status = STORE_PREPARING
                    transaction.store = store
                    transaction.paymentCharge = paymentCharge
                    
                    
                    ServerHelper.shared.createOrder(order: transaction) { (data) in
                        
                        transaction._id = data._id
                        
                        DispatchQueue.main.async {
                            self.navigationController?.dismiss(animated: true, completion: {
                                self.listener?.onListUpdate(cart: Array<Cart>())
                                self.listener2?.onTransactionSuccess(transaction: transaction)
                            })
                        }
                    }
                }
            }
        }
    }
