
//
//  addNewMenuCollection.swift
//  dVolada Aliado
//
//  Created by Miguel Ledezma on 30/09/20.
//  Copyright © 2020 Miguel Ledezma. All rights reserved.
//

import UIKit

class AddNewMenuCollection: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AddNewMenuCell.self, forCellWithReuseIdentifier: "cellid")
        collectionView.isScrollEnabled = false
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! AddNewMenuCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width,height: view.frame.height)
    }
}
