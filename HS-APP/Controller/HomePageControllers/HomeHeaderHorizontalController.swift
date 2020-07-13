//
//  HomeHeaderHorizontalController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/15/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit
import SDWebImage

struct HSCollection: Decodable {
    let name: String
    let imageUrl: String
}

class HomeHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    
    let cellId           = "cellId"
    var GalleryItems     = [GalleryItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // HomePageHeaderCell
        collectionView.register(HomePageHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(
            width: 250,
            height: view.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return .init(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GalleryItems.count
    }
    
//     TODO: Create HSCollectionCell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell                = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePageHeaderCell
        let collection          = self.GalleryItems[indexPath.item]
        cell.titleLabel.text    = collection.title
        cell.imageView.sd_setImage(with: URL(string: collection.imageUrl))
        return cell
    }
}
