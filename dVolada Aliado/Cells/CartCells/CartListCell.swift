//
//  CartListCell.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 12/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
class CartListCell: UICollectionViewCell, UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   
    
    var subTotal = 0 {
        didSet {
            cartCollectionView.reloadData()
        }
    }
    
    
    var fee : Int? {
        didSet {
            DispatchQueue.main.async {
                self.detailPriceCollectionView.reloadData()
            }
        }
    }
    
    var total = 0
    
    var extraFee = 0
    let cartInnerCellID = "cartInnerCellID"
    let priceCellID = "priceCellID"
    
    var cartCollectionView : UICollectionView!
    var detailPriceCollectionView : UICollectionView!
    
    var list = Array<Cart>() {
        didSet {
            cartCollectionView.reloadData()
            print("RELOADING DATA")
            
            let productsHeight = (list.count * HEIGHT_DISH_HORIZONTAL) + 20
            
            print("ProductsHeight CartListCell.swift list.count: \(list.count)  \(HEIGHT_DISH_HORIZONTAL) \(productsHeight)")
        
            NSLayoutConstraint.activate([
                cartCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(productsHeight)),
            ])
        }
    }
    
    
    var store : Store? {
        didSet {
            storeTitleLabel.text = store?.name
        }
    }
    
    let storeTitleLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = false
        label.textColor = .black
        
        return label
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == cartCollectionView){
            return list.count
        }
        
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == cartCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cartInnerCellID, for: indexPath) as! DishHorizontalCell
            
            cell.dish = list[indexPath.item].dish
            cell.shouldHideButton = true
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: priceCellID, for: indexPath) as! PriceCell
        
        if(indexPath.item == 0){
            cell.titleConceptLabel.text = "Subtotal"
            cell.titlePriceLabel.text = "$\(subTotal).00"
        }
        
        if(indexPath.item == 1){
            cell.titleConceptLabel.text = "Envio"
            
            if let finalFee = fee {
                cell.titlePriceLabel.text = "$\(finalFee + extraFee).00"
            }else{
                cell.titlePriceLabel.text = "Calculando..."
            }
            
        }
        if(indexPath.item == 2){
            cell.titleConceptLabel.text = "Total"
            if let finalFee = fee {
                cell.titlePriceLabel.text = "$\(finalFee + extraFee + subTotal).00"
            }else{
                cell.titlePriceLabel.text = "Calculando..."
            }
        }
    
        return cell
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(storeTitleLabel)
        
        
        let layout = UICollectionViewFlowLayout()
        
        
        cartCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cartCollectionView.register(DishHorizontalCell.self, forCellWithReuseIdentifier: cartInnerCellID)
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        cartCollectionView.backgroundColor = .white
        cartCollectionView.isScrollEnabled = false

        let layout2 = UICollectionViewFlowLayout()
        
        detailPriceCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout2)
        detailPriceCollectionView.translatesAutoresizingMaskIntoConstraints = false
        detailPriceCollectionView.register(PriceCell.self, forCellWithReuseIdentifier: priceCellID)
        detailPriceCollectionView.delegate = self
        detailPriceCollectionView.dataSource = self
        detailPriceCollectionView.backgroundColor = .white
        
        addSubview(cartCollectionView)
        addSubview(detailPriceCollectionView)
        
        
        let productsHeight = (list.count * HEIGHT_DISH_HORIZONTAL) + 120
        
        print("ProductsHeight CartListCell.swift list.count: \(list.count)  \(HEIGHT_DISH_HORIZONTAL) \(productsHeight)")
        
        
        NSLayoutConstraint.activate([
        
            storeTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            storeTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            storeTitleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            cartCollectionView.topAnchor.constraint(equalTo: storeTitleLabel.bottomAnchor, constant: 15),
            cartCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            cartCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            //cartCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(productsHeight)),
            
            detailPriceCollectionView.topAnchor.constraint(equalTo: cartCollectionView.bottomAnchor, constant: 10),
            detailPriceCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            detailPriceCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            detailPriceCollectionView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(collectionView == cartCollectionView){
            return CGSize(width: frame.width - 40, height: CGFloat(HEIGHT_DISH_HORIZONTAL))
        }
        
        return CGSize(width: frame.width, height: 25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
