//
//  PreviewScreenShotController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 6/1/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class PreviewScreenShotController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var product: Product? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    class ScreenShotCell: UICollectionViewCell {
        
        let imageView = UIImageView(cornerRadius: 12)
        
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            imageView.backgroundColor = .purple
            addSubview(imageView)
            imageView.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell                = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotCell
        let screenShotUrl       = self.product?.images[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: screenShotUrl?.src ?? ""))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(
            width: 250,
            height: view.frame.height)
    }
}
