//
//  DishController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import UIKit

class DishController: UICollectionViewController , UICollectionViewDelegateFlowLayout, InputListener, ModifierListener {
    
    func onUpdateList(list: Array<Options>) {
        
        
        var totalValue = 0
        
        dish!.modifiers!.forEach { (it) in
             
            it.optionsSelected?.forEach({ (options) in
                totalValue += options.fee!
            })
            
        }
        
        if (totalValue == 0) {
            dish?.price = dish!.originalPrice
        }
        
        
        extraOptionsPrice = totalValue
        calculatePrice()
        
        collectionView.reloadData()
    }
    
    var listener : CartListener?
    var extraOptionsPrice = 0
    var price = 1
    
    var observation = ""
    
    var containerAddCart : UIButton =  {
        
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.00, green:0.62, blue:0.00, alpha:1.00)
        view.setTitle("Agregar al carrito", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
        
        return view
    }()
    
    
    
    var finalPriceTextView : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 14)
        text.backgroundColor = .clear
        text.isEditable = false
        text.isSelectable = false
        text.textColor = .white
        text.isScrollEnabled = false
        text.sizeToFit()
        return text
    }()
    
    
    
    func onEditTextChanged(text: String) {
        print("TEXT CHANGED \(text)")
        observation = text
    }
    
    
    
    func calculatePrice(){
        
        price = (dish!.originalPrice! + extraOptionsPrice) * quantity
        dish!.price = dish!.originalPrice! + extraOptionsPrice
        
        print("EXTRA OPTIONS \(extraOptionsPrice)")
        
        finalPriceTextView.text = "$\(price).00"
    }
    
    var quantity = 1 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    var dish : Dish?{
        didSet {
            collectionView.reloadData()
            navigationItem.title = dish?.title
            
            dish!.originalPrice = dish!.price
            
            dish!.modifiers!.forEach { (it) in
                it.optionsSelected = Array()
            }
            
            
            finalPriceTextView.text = "$\(dish!.originalPrice!).00"
        }
    }
    
    
    var idCell = "idCell"
    var modifierID = "modifierID"
    var quantityCell = "quantityCell"
    
    
    @objc func addItemToCart(){
        
        let cart = Cart()
        cart.dish = dish
        cart.observation = observation
        cart.quantity = quantity
        
        
        if (!(dish?.modifiers?.isEmpty ?? false)) {
            
            var listModifier = Array<Modifier>()
            
            dish!.modifiers!.forEach { (it) in
                
                if (it.optionsSelected != nil && !it.optionsSelected!.isEmpty ) {
                    let modifier = Modifier()
                    modifier.options = it.optionsSelected
                    modifier.title = it.title
                    listModifier.append(modifier)
                }
                
            }
            
            dish?.modifiers = listModifier
            
            
        }else{
             dish?.modifiers = Array()
        }
        
        
        
        listener?.onItemAdded(cart: cart)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.backgroundColor = .white
        collectionView.register(DishHeaderCell.self, forCellWithReuseIdentifier: idCell)
        collectionView.register(ModifierCell.self, forCellWithReuseIdentifier: modifierID)
        collectionView.register(QuantityCell.self, forCellWithReuseIdentifier: quantityCell)
        
        
        view.addSubview(containerAddCart)
        
        
        
        NSLayoutConstraint.activate([
            
            containerAddCart.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerAddCart.rightAnchor.constraint(equalTo: view.rightAnchor),
            containerAddCart.leftAnchor.constraint(equalTo: view.leftAnchor),
            containerAddCart.heightAnchor.constraint(equalToConstant: 80)
            
        ])
        
        containerAddCart.addSubview(finalPriceTextView)
        
        
        NSLayoutConstraint.activate([
            finalPriceTextView.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -30),
            finalPriceTextView.centerYAnchor.constraint(equalTo: containerAddCart.centerYAnchor)
        ])
        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleExit(){
        self.navigationController?.popViewController(animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(dish?.modifiers != nil && !((dish?.modifiers?.isEmpty)!)){
            return 3
        }
        
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(dish?.modifiers != nil && indexPath.item == 1  && !((dish?.modifiers?.isEmpty)!)){
            let cellModifier = collectionView.dequeueReusableCell(withReuseIdentifier: modifierID, for: indexPath) as! ModifierCell
            cellModifier.list = dish?.modifiers as! [Modifier]
            cellModifier.modifierListener = self
            return cellModifier
        }else if(indexPath.item == 1){
            //modifier empty
            let cellQuantity = collectionView.dequeueReusableCell(withReuseIdentifier: quantityCell, for: indexPath) as! QuantityCell
            cellQuantity.addButton.addTarget(self, action: #selector(handleIncrementalQuantity), for: .touchUpInside)
            cellQuantity.restButton.addTarget(self, action: #selector(handleDecrementQuantity), for: .touchUpInside)
            cellQuantity.quantity = quantity
            cellQuantity.listener = self
            return cellQuantity
            
        }else if(indexPath.item == 2){
            let cellQuantity = collectionView.dequeueReusableCell(withReuseIdentifier: quantityCell, for: indexPath) as! QuantityCell
            cellQuantity.addButton.addTarget(self, action: #selector(handleIncrementalQuantity), for: .touchUpInside)
            cellQuantity.restButton.addTarget(self, action: #selector(handleDecrementQuantity), for: .touchUpInside)
            cellQuantity.quantity = quantity
            cellQuantity.listener = self
            return cellQuantity
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! DishHeaderCell
        cell.dish = dish
        
        return cell
    }
    
    @objc func handleDecrementQuantity(){
        if(quantity > 1){
            quantity = quantity - 1
            
            calculatePrice()
        }
    }
    
    @objc func handleIncrementalQuantity(){
        quantity = quantity + 1
        calculatePrice()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        if(dish?.modifiers != nil && indexPath.item == 1  && !((dish?.modifiers?.isEmpty)!)){
            
            var height = 0
            
            dish!.modifiers!.forEach { (modifier) in
                height = (modifier.options!.count * 100) + height
            }
            
            let width = view.frame.width
              
            return CGSize(width: width , height: CGFloat(height))
        }
        
        return CGSize(width: view.frame.width, height: 360)
    }
}
