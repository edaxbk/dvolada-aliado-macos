//
//  UploadVideoController.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 06/04/21.
//  Copyright © 2021 Miguel Ledezma. All rights reserved.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import AVFoundation

class UploadVideoController : UICollectionViewController , UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let imagePicker = UIImagePickerController()
    var videos = [URL]()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.addTarget(self, action: #selector(acctionBtnGaleria), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 50) .isActive = true
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "hid")
        collectionView.contentInset = UIEdgeInsets(top: 20,left: 20,bottom: 0,right: 20)
        
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/edax-8cf24.appspot.com/o/IMG_0032.MOV?alt=media&token=176cdcab-7f6f-4504-87c9-23e6b549e343")
        videos.append((url)!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Videos Coun::",videos.count)
        return videos.count
   }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 50, height: 300)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hid", for: indexPath) as! VideoCell
        cell.imgView.image = thumbnailImageForFileUrl(videos[indexPath.item])
        print("inndexpat::",indexPath.item)
//        cell.deleteBtn.addTarget(self, action: videos.remove(at: indexPath.item), for: .touchUpInside)

        cell.backgroundColor = .green
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    //Funciones para agregar un video
    func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        collectionView.reloadData()
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let videoUrl = info[(UIImagePickerController.InfoKey.mediaURL).rawValue] as? URL {
                videos.append(videoUrl)
        }
        self.dismiss(animated: true,completion: nil)
    }
    
     @objc func acctionBtnGaleria(_sender : UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.movie"]
        imagePicker.navigationBar.tintColor =  .black
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
        
        let asset = AVAsset(url: fileUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        print("Image::",fileUrl)
        do {
            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
            return UIImage(cgImage: thumbnailCGImage)
            
        } catch let err {
            print(err)
        }
        
        return nil
    }

    @objc func deleteVideoCell() {
            print("Eliminar cell")
        videos.remove(at: 0)
        collectionView.reloadData()
        //videos.remove(at: index.item)
        
    }
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
}
