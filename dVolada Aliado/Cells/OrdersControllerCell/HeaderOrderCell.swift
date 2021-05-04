//
//  HeaderOrderCell.swift
//  dVolada Aliado
//
//  Created by Luis Santiago on 18/10/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//
import UIKit
import Kingfisher

class HeaderOrderCell : UICollectionViewCell {
    
    
    var titleTab : String? {
        didSet {
            titleMenuView.text = titleTab
        }
    }
    
    
    var listener : HeaderListener?
    
    var logoImageView : UIImageView = {
       
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 40
    
        return image
        
    }()
    
    var whiteContainer : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 30
        container.layer.masksToBounds = true
        return container
    }()
    
    
    
    let deliveryLabelText : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        label.font = UIFont(name: "Manrope-Semibold", size: 12)
        label.backgroundColor = .clear
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let titleMenuView : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    
    let directionContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        
        let store = LocalHelper.shared.getClient()
        if(store?.url_logo != nil){
            logoImageView.loadImage(url: (store?.url_logo)!)
        }
        
        deliveryLabelText.text = store?.name
        
        
        addSubview(whiteContainer)
        addSubview(titleMenuView)
        addSubview(deliveryLabelText)
        addSubview(logoImageView)
        
        
        
     
        
    
        
        
        whiteContainer.layerGradient(startPoint: .topLeft, endPoint: .bottomRight, colorArray: [UIColor.primaryColor.cgColor, UIColor.middleColor.cgColor , UIColor.secondaryColor.cgColor], type: .axial)
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        logoImageView.isUserInteractionEnabled = true
        logoImageView.addGestureRecognizer(singleTap)
        
        
        
        switch UIDevice.current.userInterfaceIdiom {
         case .phone:
             // It's an iPhone
            titleMenuView.font = UIFont.systemFont(ofSize: 18)
            titleMenuView.font = UIFont.systemFont(ofSize: 12)
            
            logoImageView.layer.cornerRadius = 30
            
            NSLayoutConstraint.activate([
                
                whiteContainer.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                whiteContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
                whiteContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
                whiteContainer.heightAnchor.constraint(equalToConstant: frame.height)
                
            ])
            
             
            NSLayoutConstraint.activate([
                

                deliveryLabelText.centerYAnchor.constraint(equalTo: whiteContainer.centerYAnchor, constant: -10),
                deliveryLabelText.leftAnchor.constraint(equalTo: leftAnchor , constant: 40),
                deliveryLabelText.rightAnchor.constraint(equalTo: rightAnchor , constant: -80),
                
                titleMenuView.topAnchor.constraint(equalTo: deliveryLabelText.bottomAnchor , constant: 5),
                titleMenuView.leftAnchor.constraint(equalTo: leftAnchor , constant: 40),
                titleMenuView.rightAnchor.constraint(equalTo: rightAnchor , constant: -80),
                
                logoImageView.centerYAnchor.constraint(equalTo: whiteContainer.centerYAnchor , constant: -5),
                logoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
                logoImageView.heightAnchor.constraint(equalToConstant: 60),
                logoImageView.widthAnchor.constraint(equalToConstant: 60),
                
                
            ])
            break
         case .pad:
             // It's an iPad (or macOS Catalyst)
            
            NSLayoutConstraint.activate([
                
                whiteContainer.topAnchor.constraint(equalTo: topAnchor, constant: 40),
                whiteContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
                whiteContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
                whiteContainer.heightAnchor.constraint(equalToConstant: frame.height)
                
            ])
            
            
             
            NSLayoutConstraint.activate([
                

                deliveryLabelText.centerYAnchor.constraint(equalTo: whiteContainer.centerYAnchor, constant: -25),
                deliveryLabelText.leftAnchor.constraint(equalTo: leftAnchor , constant: 40),
                deliveryLabelText.rightAnchor.constraint(equalTo: rightAnchor , constant: -40),
                
                
                titleMenuView.topAnchor.constraint(equalTo: deliveryLabelText.bottomAnchor , constant: 5),
                titleMenuView.leftAnchor.constraint(equalTo: leftAnchor , constant: 40),
                titleMenuView.rightAnchor.constraint(equalTo: rightAnchor , constant: -40),
                
                logoImageView.centerYAnchor.constraint(equalTo: whiteContainer.centerYAnchor),
                logoImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
                logoImageView.heightAnchor.constraint(equalToConstant: 80),
                logoImageView.widthAnchor.constraint(equalToConstant: 80),
                
                
            ])
            
            break
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
    
    @objc func tapDetected() {
        
        listener?.onLogoPressed()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension UIImageView {
    
    
    func loadImageCropped(url : String){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string : url)) { result in
            switch result {
            case .success(let value):
                self.image = self.cropImageToSquare(image: value.image)
            case .failure(let _):
                break
            }
            
        }
    }
    
    func loadImage(url : String){
        self.kf.indicatorType = .activity
        let remoteURL = URL(string: url)
        self.kf.setImage(with: remoteURL)
    }
    
    
   func cropImageToSquare(image: UIImage) -> UIImage? {
       var imageHeight = image.size.height
       var imageWidth = image.size.width

       if imageHeight > imageWidth {
           imageHeight = imageWidth
       }
       else {
           imageWidth = imageHeight
       }

       let size = CGSize(width: imageWidth, height: imageHeight)

       let refWidth : CGFloat = CGFloat(image.cgImage!.width)
       let refHeight : CGFloat = CGFloat(image.cgImage!.height)

       let x = (refWidth - size.width) / 2
       let y = (refHeight - size.height) / 2

       let cropRect = CGRect(x: x, y: y, width: size.height, height: size.width)
       if let imageRef = image.cgImage!.cropping(to: cropRect) {
           return UIImage(cgImage: imageRef, scale: 0, orientation: image.imageOrientation)
       }

       return nil
   }
}
