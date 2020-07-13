//
//  HomePageDetailController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/27/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit


class HomePageDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let appId: String
    
    init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var products: Product?
    
    
    let detailCellId = "detailCellId"
    let previewCellId = "previewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(HomePageDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! HomePageDetailCell
            cell.products = products
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.horizontalController.product = self.products
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        
        if indexPath.item == 0 {
            
            let dummyCell = HomePageDetailCell(frame: .init(
                x: 0,
                y: 0,
                width: view.frame.width,
                height: 1000))
            
            dummyCell.products = products
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(
                width: view.frame.width,
                height: 1000))
            height = estimatedSize.height
            
        } else if indexPath.item == 1 {
            height = 500
            
        } else {
            height = 280
        }
        
        return .init(
            width: view.frame.width,
            height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(
            top: 0,
            left: 0,
            bottom: 16,
            right: 0)
    }
}
