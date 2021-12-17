//
//  ExtensionUIImageView.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 10/06/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImageCropped(url : String){
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string : url), completionHandler:  { result in
            switch result {
            case .success(let value):
                self.image = self.cropImageToSquare(image: value.image)
            case .failure( _):
                break
            }
            
        })
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
