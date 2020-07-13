//
//  HomePageHorizontalController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/29/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class HomePageHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var productGroup: [Product]?
    
    var didSelectHandler: ((ProductImage) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(HomePageRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16)
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productGroup?.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell                        = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePageRowCell
        let product                     = productGroup?[indexPath.row]
        cell.nameLabel.text             = product?.name
        cell.categoryLabel.text         = removeHTMLTags(html: product?.short_description ?? "") 
        cell.imageView.sd_setImage(with: URL(string: product?.images[0].src ?? ""))
        return cell
    }
    
    
    let topBottomPadding: CGFloat       = 12
    let lineSpacing: CGFloat            = 10
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 2
        return .init(
            width: view.frame.width - 48,
            height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(
            top: topBottomPadding,
            left: 0,
            bottom: topBottomPadding,
            right: 0)
    }
}

