//
//  ProductSearchController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/27/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit
import SDWebImage

class ProductSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellId = "id1234"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label                   = UILabel()
        label.text                  = "Please enter a search Requirement"
        label.textAlignment         = .center
        label.font                  = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appId = String()
        let homePageDetailController = HomePageDetailController(appId: appId)
        navigationController?.pushViewController(homePageDetailController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(
            padding: .init(
                top: 100,
                left: 50,
                bottom: 0,
                right: 50))
    }
    
    var timer: Timer?
    
    
    fileprivate func setUpSearchBar() {
        definesPresentationContext                      = true
        navigationItem.searchController                 = self.searchController
        navigationItem.hidesSearchBarWhenScrolling      = false
        searchController.searchBar.delegate             = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.fetchAllProducts(searchTerm: searchText) { (products , err) in
                if let err = err {
                    print("Failed to fetch products:", err)
                    return
                }
                self.productResults = products ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    
    fileprivate var productResults = [Product]()
    
}
