//
//  EditDishMenuController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 09/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import SCLAlertView

class EditDishMenuController: UIViewController, UITextViewDelegate, UITableViewDelegate,ModifierAddListener{
        
    func onModifierSelected(modifier: Modifier) {
        self.modifiers.append(modifier)
        self.tableView.reloadData()
    }
    
    var menuID = "menuID"
    var modifiers = Array<Modifier>()
    var imgData = Data()

    var dish : Dish? {
        didSet {
            
            if let title = dish?.title{
                nameDishText.text = title
            }
            if let description = dish?.description{
                descDishText.text = description
            }
            if let price = dish?.price{
                priceDishText.text = String(price)
            }
            if let image = dish?.images?.first{
                addDishImg.loadImage(url: image)
            }
            if let isAvailable = dish?.isAvailable {
                switchAvailable.isOn = isAvailable
            }
            if let modifiers = dish?.modifiers {
                self.modifiers = modifiers
            }
        }
    }
    
    
    var switchAvailable : UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    var viewDish : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Editar platillo"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    var addDishImg : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    let imageButon : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    let nameDishText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(18)
        text.placeholder = ("Nombre del producto")
        return text
    }()
    
    
    let descDishText : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 18)
        text.isScrollEnabled = false
        return text
    }()
    
    let priceDishText : UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = text.font?.withSize(18)
        text.placeholder = ("Precio")
        text.keyboardType = .numberPad
        return text
    }()
    
    let modificadorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Modificador"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let modificadorBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.setTitle("Agregar Modificador", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    let confirmBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        
        
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(18)
        btn.setTitle("GUARDAR", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let deleteBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.9991019368, green: 0.2345812917, blue: 0.006988597102, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        
        
        btn.titleLabel?.font = btn.titleLabel?.font.withSize(18)
        btn.setTitle("ELIMINAR", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    //Lineas Grises
    let lineBottonH: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    
    let lineBottonH2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    
    let lineBottonH3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        return label
    }()
    //Etiquetas
    
    let nameProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.text = "Nombre del producto"
        return label
    }()
    let descProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.text = "Descripcion del producto"
        return label
    }()
    let priceProduct: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(15)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.text = "Precio"
        return label
    }()
    
    let pickerImage: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.navigationBar.tintColor =  .black
        return imagePicker
    }()
    
    var tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.backgroundColor =  .white
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descDishText.delegate = self
        pickerImage.delegate = self
        
        tableView.dataSource = self
        tableView.delegate =  self
        
        title = "Editar"
        
        view.addSubview(scrollView)
        view.backgroundColor = .purple
        scrollView.backgroundColor = .white
        tableView.backgroundColor = .white
        viewDish.backgroundColor = .white
        
        scrollView.addSubview(viewDish)
        
        viewDish.addSubview(titleLabel)
        viewDish.addSubview(addDishImg)
        viewDish.addSubview(nameProduct)
        viewDish.addSubview(nameDishText)
        viewDish.addSubview(lineBottonH)
        viewDish.addSubview(descProduct)
        viewDish.addSubview(descDishText)
        viewDish.addSubview(lineBottonH2)
        viewDish.addSubview(priceProduct)
        viewDish.addSubview(priceDishText)
        viewDish.addSubview(lineBottonH3)
        viewDish.addSubview(modificadorLabel)
        viewDish.addSubview(modificadorBtn)
        viewDish.addSubview(switchAvailable)

        
        viewDish.addSubview(tableView)
        
        viewDish.addSubview(confirmBtn)
        viewDish.addSubview(deleteBtn)
        
        
        viewDish.addSubview(imageButon)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            viewDish.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            viewDish.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            viewDish.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            viewDish.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            viewDish.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            //---------------------------
            titleLabel.topAnchor.constraint(equalTo: viewDish.topAnchor,constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            switchAvailable.rightAnchor.constraint(equalTo: viewDish.rightAnchor,constant: -20),
            switchAvailable.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            addDishImg.centerXAnchor.constraint(equalTo: viewDish.centerXAnchor),
            addDishImg.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            addDishImg.heightAnchor.constraint(equalToConstant: 200 ),
            addDishImg.widthAnchor.constraint(equalToConstant: 200),
            
            imageButon.centerXAnchor.constraint(equalTo: viewDish.centerXAnchor),
            imageButon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageButon.heightAnchor.constraint(equalToConstant: 200 ),
            imageButon.widthAnchor.constraint(equalToConstant: 200),
            
            nameProduct.topAnchor.constraint(equalTo: nameDishText.topAnchor,constant: -20),
            nameProduct.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            nameProduct.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            nameProduct.heightAnchor.constraint(equalToConstant: 30),
            
            nameDishText.topAnchor.constraint(equalTo: addDishImg.bottomAnchor,constant: 20),
            nameDishText.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            nameDishText.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            nameDishText.heightAnchor.constraint(equalToConstant: 50),
            
            lineBottonH.bottomAnchor.constraint(equalTo: nameDishText.bottomAnchor,constant: -10),
            lineBottonH.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            lineBottonH.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            lineBottonH.heightAnchor.constraint(equalToConstant: 0.5),
            
            descProduct.topAnchor.constraint(equalTo: descDishText.topAnchor,constant: -25),
            descProduct.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            descProduct.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            descProduct.heightAnchor.constraint(equalToConstant: 30),
            
            descDishText.topAnchor.constraint(equalTo: nameDishText.bottomAnchor,constant: 20),
            descDishText.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            descDishText.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            descDishText.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            lineBottonH2.bottomAnchor.constraint(equalTo: descDishText.bottomAnchor,constant: -10),
            lineBottonH2.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            lineBottonH2.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            lineBottonH2.heightAnchor.constraint(equalToConstant: 0.5),
            
            priceProduct.topAnchor.constraint(equalTo: priceDishText.topAnchor,constant: -20),
            priceProduct.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            priceProduct.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            priceProduct.heightAnchor.constraint(equalToConstant: 30),
            
            priceDishText.topAnchor.constraint(equalTo: descDishText.bottomAnchor,constant: 20),
            priceDishText.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            priceDishText.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            priceDishText.heightAnchor.constraint(equalToConstant: 50),
            
            lineBottonH3.bottomAnchor.constraint(equalTo: priceDishText.bottomAnchor,constant: -10),
            lineBottonH3.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            lineBottonH3.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            
            modificadorLabel.topAnchor.constraint(equalTo: priceDishText.bottomAnchor,constant: 40),
            modificadorLabel.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            modificadorLabel.heightAnchor.constraint(equalToConstant: 50),
            
            modificadorBtn.topAnchor.constraint(equalTo: priceDishText.bottomAnchor,constant: 40),
            modificadorBtn.rightAnchor.constraint(equalTo: viewDish.rightAnchor,constant: -20),
            modificadorBtn.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: modificadorBtn.bottomAnchor,constant: 20),
            tableView.heightAnchor.constraint(equalToConstant: 300),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            
            confirmBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor,constant: 50),
            confirmBtn.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            confirmBtn.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            confirmBtn.heightAnchor.constraint(equalToConstant: 50),
            
            deleteBtn.topAnchor.constraint(equalTo: confirmBtn.bottomAnchor,constant: 20),
            deleteBtn.leftAnchor.constraint(equalTo: viewDish.leftAnchor,constant: 20),
            deleteBtn.rightAnchor.constraint(equalTo: viewDish.rightAnchor, constant: -20),
            deleteBtn.heightAnchor.constraint(equalToConstant: 50),
            deleteBtn.bottomAnchor.constraint(equalTo: viewDish.bottomAnchor,constant: -100)
            
        ])
        textViewDidChange(descDishText)
        
        switchAvailable.addTarget(self, action: #selector(valueChange), for: .valueChanged)

        
        modificadorBtn.addTarget(self, action: #selector(actionModifierBtn), for: .touchUpInside)
        
        imageButon.addTarget(self, action: #selector(acctionBtnGaleria), for: .touchUpInside)
        
        deleteBtn.addTarget(self, action: #selector(actionDeleteBtn), for: .touchUpInside)
        
        confirmBtn.addTarget(self, action: #selector(actionConfirmBtn), for: .touchUpInside)
        
        tableView.register( ModificadorCell.self, forCellReuseIdentifier: menuID)
        
    }
    @objc func valueChange(_sender : UISwitch) {
        
    }
    func showErrorMessage(_ message : String){
        SCLAlertView().showError("Error", subTitle: message) // Error
    }
    
    
    @objc func actionModifierBtn(){
        let modifiertableView = ModifierDishTableView()
        modifiertableView.title = "Modificadores"
        modifiertableView.listener = self
        self.navigationController?.pushViewController(modifiertableView, animated: true)
    }
    
    @objc func actionDeleteBtn(){
        ServerHelper.shared.deleteDishMenuFromStore(id: (self.dish?._id)!) { (succes) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func acctionBtnGaleria(_sender : UIButton) {
        self.present(pickerImage, animated: true, completion: nil)
    }
    @objc func actionConfirmBtn(_sender : UIButton) {
        
        if((nameDishText.text?.isEmpty)!){
            showErrorMessage("Nombre")
            nameDishText.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return
        }else{
            nameDishText.backgroundColor = .white
            dish?.title = nameDishText.text
        }
        
        if((descDishText.text?.isEmpty)!){
            showErrorMessage("Description")
            descDishText.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return
        }else{
            descDishText.backgroundColor = .white
            dish?.description = descDishText.text
        }
        
        if((priceDishText.text?.isEmpty)!){
            showErrorMessage("Precio")
            priceDishText.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return
        }else{
            priceDishText.backgroundColor = .white
            dish?.price = Int(priceDishText.text!)
        }
        if(modifiers.isEmpty == false){
            dish?.modifiers = modifiers
        }else{
            dish?.modifiers?.removeAll()
        }
        
        dish?.isAvailable = switchAvailable.isOn
        
        if(imgData.isEmpty == false){
            let imagenRef = FirebaseAPI.shared.storage.child("PruebaLalo/rc-upload-\(LocalHelper.shared.getClient()?._id ?? "Store")-\( Int.random(in: 10000...99999)).jpeg")
            let metadata = FirebaseAPI.shared.metadata
            metadata.contentType = "image/jpeg"
            
            imagenRef.putData(imgData ,metadata: metadata){ [self] (metadata,err) in
                guard metadata != nil else{
                    return
                }
                //Enviar url en un post::
                imagenRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        return
                    }
                
                    var arr = [""]
                    arr[0] = downloadURL.absoluteString
                    self.dish?.images = arr
                    
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data = try! encoder.encode(self.dish)
                    print("::::: -- ",String(data: data, encoding: .utf8)!)
                    
                    ServerHelper.shared.putDishFromMenu(dish: self.dish!) { (succes) in
                        print("Succes::")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }else{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try! encoder.encode(self.dish)
            print("::::: -- ",String(data: data, encoding: .utf8)!)
            
            print("UPDATE DISH")
            ServerHelper.shared.putDishFromMenu(dish: self.dish!) { (succes) in
                print("Succes::")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension EditDishMenuController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modifiers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuID) as! ModificadorCell
        cell.myView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        cell.modificador =  modifiers[indexPath.item]
        cell.tableView.heightAnchor.constraint(equalToConstant: CGFloat((modifiers[indexPath.item].options!.count) * 50)).isActive = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //Eliminar
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.modifiers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
}

extension EditDishMenuController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imgData = (image?.jpegData(compressionQuality: 0.1))!
        addDishImg.image = image
        self.dismiss(animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true,completion: nil)
    }
}
extension EditDishMenuController: UITextFieldDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
