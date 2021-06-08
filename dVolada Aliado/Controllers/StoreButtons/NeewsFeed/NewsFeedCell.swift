//
//  NeewsFeed.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 24/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit

class NewsFeedCell: UITableViewCell {
    
    var newsFeed : NewsFeed? {
        didSet{
            
            storeLogoImage.loadImageCropped(url: (newsFeed?.store?.url_logo)!)
            nameStoreLabel.text = newsFeed?.store?.name
            let date = Date.init(milliseconds: (newsFeed?.date_created!)!)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm dd-MM-yyyy "
            let dateAsString = dateFormatter.string(from: date)
            
            dateNewsFeedLabel.text = dateAsString
            contentTextLabel.text = newsFeed?.content
            
            if let numLike = newsFeed?.numLike {
                footerLabel.text =  "\(numLike) reacciones ·"
            }else{
                footerLabel.text =  "0 reacciones ·"
            }
            
            if let numCommetns = newsFeed?.numComments {
                footerLabel.text! +=  " \(numCommetns) comentarios"
            }else{
                footerLabel.text! +=  " 0 comentarios"
            }
            
            if let type = newsFeed?.type {
                switch type {
                case "text":
                    print("ES texto")
                    break
                case "image":
                    if let urlImage = newsFeed?.media?.first?.url!{
                        imageContentView.loadImageCropped(url: urlImage)
                    }
                    
                    break
                case "video":
                    print("ES video")
                    break
                default:
                    print("Ningun tipo")
                }
            }
            
            
        
        }
    }
    //Header
    
    var storeLogoImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        return image
    }()
    
    var nameStoreLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "dVolada"
        label.backgroundColor = .white
        return label
    }()
    
    var dateNewsFeedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "Fecha de publicacion"
        label.textColor = .lightGray
        label.backgroundColor = .white
        return label
    }()
    
    
    
    //Content
    var contentTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "Contenido de la publicación"
        label.backgroundColor =  .white
        return label
    }()
    
    let tempView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    var imageContentView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //Footer
    var footerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = "0 reacciones · 0 comentarios"
        label.textColor = .lightGray
        label.backgroundColor = .white
        label.textAlignment = .right
        return label
    }()
    
    var stackView : UIStackView = {
        let stackView   = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis  = .horizontal
        stackView.distribution  = .fillEqually
        stackView.alignment = .center
        stackView.spacing   = 1
        stackView.backgroundColor = .lightGray
        
        stackView.layer.cornerRadius = 5
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        
        return stackView
    }()
    
    let reactionButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.setImage(#imageLiteral(resourceName: "icons8_mexico_96"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
        btn.setTitle("ME GUSTA", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        return btn
    }()
    
    let commentsButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.setImage(UIImage(systemName: "text.bubble"), for: .normal)
        btn.imageView?.tintColor = .black
        btn.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
        btn.setTitle("Comentarios", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Agregamos a la subvista el objeto y lo ubicamos
        addSubview(storeLogoImage)
        addSubview(nameStoreLabel)
        addSubview(dateNewsFeedLabel)
        
        addSubview(contentTextLabel)
        addSubview(tempView)
        
        addSubview(footerLabel)
        
        backgroundColor = .white
        
        selectionStyle = .none
        
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.masksToBounds = false
        
        NSLayoutConstraint.activate([
            
            storeLogoImage.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            storeLogoImage.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            storeLogoImage.widthAnchor.constraint(equalToConstant: 60),
            storeLogoImage.heightAnchor.constraint(equalToConstant: 60),
            
            nameStoreLabel.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            nameStoreLabel.leftAnchor.constraint(equalTo: storeLogoImage.rightAnchor,constant: 10),
            nameStoreLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            nameStoreLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateNewsFeedLabel.topAnchor.constraint(equalTo: nameStoreLabel.bottomAnchor,constant: 5),
            dateNewsFeedLabel.leftAnchor.constraint(equalTo: storeLogoImage.rightAnchor,constant: 10),
            dateNewsFeedLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -20),
            dateNewsFeedLabel.heightAnchor.constraint(equalToConstant: 20),
            
            contentTextLabel.topAnchor.constraint(equalTo: storeLogoImage.bottomAnchor , constant: 10),
            contentTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            contentTextLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -20),
            contentTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tempView.topAnchor.constraint(equalTo: contentTextLabel.bottomAnchor ,constant: 10),
            tempView.leftAnchor.constraint(equalTo: leftAnchor),
            tempView.widthAnchor.constraint(equalTo: widthAnchor),
            tempView.heightAnchor.constraint(equalToConstant: 300),
            
            footerLabel.topAnchor.constraint(equalTo: tempView.bottomAnchor , constant: 10),
            footerLabel.heightAnchor.constraint(equalToConstant: 20),
            footerLabel.widthAnchor.constraint(equalTo: widthAnchor,constant: -20),
            footerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
        ])
        
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(reactionButton)
        stackView.addArrangedSubview(commentsButton)
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: footerLabel.bottomAnchor , constant: 10),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            reactionButton.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            
            commentsButton.heightAnchor.constraint(equalTo: stackView.heightAnchor)
            
        ])
        
        tempView.addSubview(imageContentView)
        
        NSLayoutConstraint.activate([
            
            imageContentView.topAnchor.constraint(equalTo: tempView.topAnchor),
            imageContentView.leftAnchor.constraint(equalTo: tempView.leftAnchor),
            imageContentView.rightAnchor.constraint(equalTo: tempView.rightAnchor),
            imageContentView.heightAnchor.constraint(equalToConstant: 300),

            imageContentView.bottomAnchor.constraint(equalTo: tempView.bottomAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
