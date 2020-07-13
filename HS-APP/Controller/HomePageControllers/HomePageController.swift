//
//  HomePageController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/15/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class HomePageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId      = "id"
    let headerId    = "headerId"
    
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv                 = UIActivityIndicatorView(style: .large)
        aiv.color               = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped    = true
        return aiv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(HomePageGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(HomePageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchProducts()
    }
    
    var products                = [Product]()
    var collectionGroup         = [Category]()
    var gallery                 = [GalleryItem]()
    
    
    fileprivate func fetchProducts() {
        
        var group1: Category?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchAllProducts { (products, err) in
            dispatchGroup.leave()
            group1              = Category(category: "All Products", products: products ?? [])
            self.products       = products ?? []
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGallery { (galleryItems, err) in
            dispatchGroup.leave()
            if let err = err {
                print("Error getting gallery \(err)")
            } else {
                self.gallery = galleryItems ?? []
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("completed dispatch")
            
            self.activityIndicatorView.stopAnimating()
            
            if let category = group1 {
                 self.collectionGroup.append(category)
            }
            self.collectionView.reloadData()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomePageHeader

        header.homeHeaderHorizontalController.GalleryItems = gallery
        header.homeHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(
            width: view.frame.width,
            height: 550)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionGroup.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell                                  = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePageGroupCell
        let categoryGroup                         = collectionGroup[indexPath.item]
        cell.titleLabel.text                      = categoryGroup.category
        cell.horizontalController.productGroup    = products
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            
            let controller                          = HomePageDetailController(appId: feedResult.name)
            controller.navigationItem.title         = feedResult.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(
            width: view.frame.width,
            height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(
            top: 16,
            left: 0,
            bottom: 0,
            right: 0)
    }
}
