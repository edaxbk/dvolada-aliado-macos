//
//  TabBarController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit
import ESTabBarController_swift

class HomeTabBarController: ESTabBarController, UITabBarControllerDelegate , OrderListener, OrderInvitationListener, HeaderListener{
    
    
    func onLogoPressed() {
        openStoreControllerBtn()
    }
    
    
    
    
    
    func onForceUpdate() {
        getData()
    }
    
   
    var listOfOrders = Array<Order>()
    let pending = OrdersController(collectionViewLayout: UICollectionViewFlowLayout())
    let preparing = OrdersController(collectionViewLayout: UICollectionViewFlowLayout())
    let ordersToPickUp = OrdersController(collectionViewLayout: UICollectionViewFlowLayout())
    let finishedOrders = OrdersController(collectionViewLayout: UICollectionViewFlowLayout())
    
    var lastPosition = 0
    
    let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner , .layerMinXMaxYCorner , .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBar = self.tabBar as? ESTabBar {
            tabBar.barTintColor = .white
        }
        
        self.delegate = self
        
        preparing.orderListener = self
        preparing.headerListener = self
        
        pending.orderListener = self
        pending.headerListener = self
        
        ordersToPickUp.orderListener = self
        ordersToPickUp.headerListener = self
        
        finishedOrders.orderListener = self
        finishedOrders.headerListener = self

        addCustomTabBarView()
        hideTabBarBorder()
        setupTabBar()
        
        getData()
        
        FirebaseAPI.shared.listenToTrips(_id: (LocalHelper.shared.getClient()?._id)!) { (order) in
            let alertController = NewOrderController()
            alertController.order = order
            let nav = UINavigationController(rootViewController: alertController)
            nav.modalPresentationStyle = .fullScreen
            self.navigationController?.present(nav, animated: true, completion: nil)
            self.getData()
        }
        
        FirebaseAPI.shared.checkIfStatusHasChanged(_id: LocalHelper.shared.getClient()!._id!) {
            self.getData()
        }
        
    }
    
    func getData(){
        FirebaseAPI.shared.getCurrentTrips(_id: (LocalHelper.shared.getClient()?._id)!) { [self] (list) in
            self.listOfOrders.removeAll()
            self.listOfOrders.append(contentsOf: list)
            renderList()
            
        }
    }
    
    func renderList(){
        let listToShow = getFilteredOrders(position: lastPosition, list: listOfOrders)
        showOrdersToSpecificControllers(position : lastPosition, list: listToShow)
    }
    
    
    @objc func openStoreControllerBtn() {
        
        let storeController = StoreController()
        ServerHelper.shared.getStoreById(id: (LocalHelper.shared.getClient()?._id)!) { (getstore) in
            storeController.store = getstore;
            storeController.modalPresentationStyle = .fullScreen
            self.navigationController?.present( storeController, animated: true, completion: nil)
            
        } onFailure: { (err) in
            print("Error in get store::",err)
            LocalHelper.shared.setClient(nil)
        }
    }
    
    func setupTabBar() {
        
        pending.titleTab = "Ordenes Pendientes"
        preparing.titleTab = "Ordenes en preparación"
        ordersToPickUp.titleTab = "Ordenes por recoger"
        finishedOrders.titleTab = "Ordenes terminados"
        
        
        let pendingOrdersController = UINavigationController(rootViewController: pending)
        let preparingOrdersController = UINavigationController(rootViewController: preparing)
        let ordersToPickUpController = UINavigationController(rootViewController: ordersToPickUp)
        let finishedOrdersController = UINavigationController(rootViewController: finishedOrders)
        
        
        
        pendingOrdersController.tabBarItem = ESTabBarItem.init(ItemBarContentView(), title: "Pendientes", image: #imageLiteral(resourceName: "icons8-data-pending-50"), selectedImage: #imageLiteral(resourceName: "icons8-data-pending-50"))
        preparingOrdersController.tabBarItem = ESTabBarItem.init(ItemBarContentView(), title: "Preparando", image: #imageLiteral(resourceName: "icons8-check-50"), selectedImage: #imageLiteral(resourceName: "icons8-check-50"))
        ordersToPickUpController.tabBarItem = ESTabBarItem.init(ItemBarContentView(), title: "Por recoger", image: #imageLiteral(resourceName: "icons8-scooter-50"), selectedImage: #imageLiteral(resourceName: "icons8-scooter-50"))
        finishedOrdersController.tabBarItem = ESTabBarItem.init(ItemBarContentView(), title: "Terminados", image: #imageLiteral(resourceName: "icons8-approved-delivery-50"), selectedImage: #imageLiteral(resourceName: "icons8-approved-delivery-50"))
        
        
        viewControllers = [pendingOrdersController, preparingOrdersController, ordersToPickUpController, finishedOrdersController]
        self.viewDidLayoutSubviews()
        
        customTabBarView.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
    }
   
    

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        
        switch UIDevice.current.userInterfaceIdiom {
         case .phone:
             // It's an iPhone
    
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                NSLayoutConstraint.activate([
                    customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                    customTabBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
                    customTabBarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
                    customTabBarView.heightAnchor.constraint(equalToConstant: 50)
                ])
                break
            case 1334:
                print("iPhone 6/6S/7/8")
                NSLayoutConstraint.activate([
                    customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: 4e0),
                    customTabBarView.leftAnchor.constraint(equalTo: view.leftAnchor),
                    customTabBarView.rightAnchor.constraint(equalTo: view.rightAnchor),
                    customTabBarView.heightAnchor.constraint(equalToConstant: 55)
                ])
                customTabBarView.layer.cornerRadius = 0
                break
            case 1920, 2208:
                NSLayoutConstraint.activate([
                    customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                    customTabBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
                    customTabBarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
                    customTabBarView.heightAnchor.constraint(equalToConstant: 90)
                ])
                print("iPhone 6+/6S+/7+/8+")
                
                break
            case 2436:
                NSLayoutConstraint.activate([
                    customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                    customTabBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
                    customTabBarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
                    customTabBarView.heightAnchor.constraint(equalToConstant: 90)
                ])
                print("iPhone X/XS/11 Pro")
                break
            case 2688:
                NSLayoutConstraint.activate([
                    customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                    customTabBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
                    customTabBarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
                    customTabBarView.heightAnchor.constraint(equalToConstant: 90)
                ])
                print("iPhone XS Max/11 Pro Max")
                break
            case 1792:
                NSLayoutConstraint.activate([
                    customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                    customTabBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
                    customTabBarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
                    customTabBarView.heightAnchor.constraint(equalToConstant: 90)
                ])
                print("iPhone XR/ 11 ")
                break
            default:
                print("Unknown")
            }
            
         case .pad:
             // It's an iPad (or macOS Catalyst)
        
            NSLayoutConstraint.activate([
                customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
                customTabBarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                customTabBarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                customTabBarView.heightAnchor.constraint(equalToConstant: (view.frame.height / 20) + 5)
            ])
         case .unspecified:
             // Uh, oh! What could it be?
            break
        case .tv:
            break
        case .carPlay:
            break
        case .mac:
            break
        @unknown default:
            break
        }

        
        
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    
    
    
    @objc func backToScreen(){
        dismiss(animated: true, completion: nil)    
    }
    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        guard let items = tabBar.items else { return }
        lastPosition = items.index(of: item)!
        renderList()
        super.tabBar(tabBar, didSelect: item)
        
    }
    
    func getFilteredOrders(position : Int, list : Array<Order>) -> Array<Order> {
        
        
        var listToReturn = Array<Order>()
        
        switch position {
        case 0:
            listToReturn = list.filter { $0.status == "STORE_PENDING"}
        case 1 :
            listToReturn = list.filter { $0.status == "STORE_PREPARING" || $0.status == "DRIVER_ACCEPTED"}
        case 2 :
            listToReturn = list.filter { $0.status == "STORE_WAITING_DRIVER" || $0.status == "DRIVER_DELIVERING_TO_CLIENT"}
        case 3 :
            listToReturn = list.filter { $0.status == "DRIVER_FINISH_RIDE"}
        default:
            break
        }
        
        
        print("RETURING \(listToReturn.count)")
        
        return listToReturn
        
    }

    
    func showOrdersToSpecificControllers(position : Int, list : Array<Order>) -> Void {
        
        
        switch position {
        case 0:
            pending.listOfOrders = list
        case 1 :
            preparing.listOfOrders = list
        case 2 :
            ordersToPickUp.listOfOrders = list
        case 3 :
            finishedOrders.listOfOrders = list
        default:
            break
        }
        
        view.layoutIfNeeded()
        
    }
    
    func onOrderSelected(order: Order, position: Int) {
        let controller = DetailOrderController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.order = order
        controller.listener = self
        let nav = UINavigationController(rootViewController: controller)
        navigationController?.present(nav, animated: true, completion: nil)
    }
    
    
    func onOrderAccepted() {
        getData()
    }
    
    func onOrderRejected() {
        getData()
    }
    

}



extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

