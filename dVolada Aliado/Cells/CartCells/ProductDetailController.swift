//
//  ProductDetailController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 08/05/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailController: UIViewController , UIGestureRecognizerDelegate{
    
    var quantityFromView = 0
    
    var position : Int?
    
    var cartProduct : Cart?{
        didSet{
            titleProductname.text = cartProduct!.dish!.title
            quantityTextView.text = "\(cartProduct!.quantity!)"
            quantityFromView = cartProduct!.quantity!
            descripcionText.text = ("$\(cartProduct!.dish!.price!).00")
        }
    }
    
    var delegate : CartUpdateProtocol!
    
    let menuView = UIView()
    
    let menuHeight = UIScreen.main.bounds.height / 2
    
    let widthOfDevice = UIScreen.main.bounds.width
    
    var isPresenting = false
    
    let horizontalStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually;
        return stack
    }()
    
    
    let horizontalStack2 : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually;
        return stack
    }()
    
    
    let addQuantityButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onQuantityAdd), for: .touchUpInside)
        return button
    }()
    
    
    @objc func onQuantityAdd (){
        quantityFromView = quantityFromView + 1
        quantityTextView.text = String(quantityFromView)
        cartProduct?.quantity = quantityFromView
    }
    
    @objc func restQuantity(){
        if quantityFromView > 1 {
            quantityFromView = quantityFromView - 1
            quantityTextView.text = String(quantityFromView)
            cartProduct?.quantity = quantityFromView
        }
    }
    
    @objc func onUpdate(){
        if let positionInCart = position {
            delegate.onProductUpdate(position: positionInCart, cartProduct: cartProduct!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func onDelete(){
        if let positionInCart = position {
            delegate.onProductDelete(position: positionInCart)
            dismiss(animated: true, completion: nil)
        }
    }
    
    let restQuantityButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(restQuantity), for: .touchUpInside)
        return button
    }()
    
    
    let updateButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Actualizar", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        button.layer.cornerRadius  = 20
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onUpdate), for: .touchUpInside)
        return button
    }()
    
    
    let deleteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Eliminar", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius  = 20
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        return button
    }()
    
    
    let quantityTextView : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 18)
        text.isEditable = false
        text.isSelectable = false
        text.isScrollEnabled = false
        return text
    }()
    
    let titleProductname : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 20)
        text.isEditable = false
        text.isSelectable = false
        text.isScrollEnabled = false
        return text
    }()
    
    let descripcionText : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 16)
        text.isEditable = false
        text.isSelectable = false
        return text
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        setUpRootView()
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBaseTapOnly))
        doubleTapRecognizer.numberOfTapsRequired = 1
        doubleTapRecognizer.delegate = self
        self.view.addGestureRecognizer(doubleTapRecognizer)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    @objc func onBaseTapOnly(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            //react to tap
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    func setUpRootView(){
        view.addSubview(menuView)
        menuView.backgroundColor = .white
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.heightAnchor.constraint(equalToConstant: menuHeight),
            menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        
        menuView.addSubview(titleProductname)
        menuView.addSubview(descripcionText)
        menuView.addSubview(horizontalStack)
        menuView.addSubview(horizontalStack2)
        menuView.addSubview(updateButton)
        menuView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            titleProductname.topAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.topAnchor , constant : 20),
            titleProductname.leadingAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.leadingAnchor),
            titleProductname.trailingAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.trailingAnchor),
            titleProductname.heightAnchor.constraint(equalToConstant: 40),
            
            descripcionText.topAnchor.constraint(equalTo: titleProductname.bottomAnchor , constant : 10),
            descripcionText.leadingAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.leadingAnchor , constant : 20),
            descripcionText.trailingAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.trailingAnchor , constant : -20),
            descripcionText.heightAnchor.constraint(equalToConstant: 50),
            
            horizontalStack.topAnchor.constraint(equalTo: descripcionText.bottomAnchor, constant: 10),
            horizontalStack.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            horizontalStack.widthAnchor.constraint(equalToConstant: 150),
            horizontalStack.heightAnchor.constraint(equalToConstant: 40),
            
            
            horizontalStack2.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 25),
            horizontalStack2.centerXAnchor.constraint(equalTo: menuView.centerXAnchor),
            horizontalStack2.widthAnchor.constraint(equalToConstant: 300),
            horizontalStack2.heightAnchor.constraint(equalToConstant: 40),
            
            ])
        
        
        
        let firstButtonContainer = UIView();
        firstButtonContainer.addSubview(addQuantityButton);
        
        addQuantityButton.centerXAnchor.constraint(equalTo: firstButtonContainer.centerXAnchor).isActive = true;
        addQuantityButton.centerYAnchor.constraint(equalTo: firstButtonContainer.centerYAnchor).isActive = true;
        addQuantityButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        
        let secondButtonContainer = UIView();
        secondButtonContainer.addSubview(restQuantityButton);
        
        //Setting constraints
        restQuantityButton.centerXAnchor.constraint(equalTo: secondButtonContainer.centerXAnchor).isActive = true;
        restQuantityButton.centerYAnchor.constraint(equalTo: secondButtonContainer.centerYAnchor).isActive = true;
        restQuantityButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        
        let thirdViewContainer = UIView();
        thirdViewContainer.addSubview(quantityTextView);
        
        quantityTextView.centerXAnchor.constraint(equalTo: thirdViewContainer.centerXAnchor).isActive = true;
        quantityTextView.centerYAnchor.constraint(equalTo: thirdViewContainer.centerYAnchor).isActive = true;
        quantityTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        
        horizontalStack.addArrangedSubview(firstButtonContainer)
        horizontalStack.addArrangedSubview(thirdViewContainer)
        horizontalStack.addArrangedSubview(secondButtonContainer)
        
        
        
        //Second row
        let updateContainer = UIView();
        updateContainer.addSubview(updateButton);
        
        updateButton.centerXAnchor.constraint(equalTo: updateContainer.centerXAnchor).isActive = true;
        updateButton.centerYAnchor.constraint(equalTo: updateContainer.centerYAnchor).isActive = true;
        updateButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        
        let deleteContainer = UIView();
        deleteContainer.addSubview(deleteButton);
        
        deleteButton.centerXAnchor.constraint(equalTo: deleteContainer.centerXAnchor).isActive = true;
        deleteButton.centerYAnchor.constraint(equalTo: deleteContainer.centerYAnchor).isActive = true;
        deleteButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true;
        
        
        horizontalStack2.addArrangedSubview(updateContainer)
        horizontalStack2.addArrangedSubview(deleteContainer)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)

    }
}


extension ProductDetailController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            menuView.frame.origin.y += menuHeight
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y -= self.menuHeight
                
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.menuView.frame.origin.y += self.menuHeight
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}



