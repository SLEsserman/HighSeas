//
//  HomePageHeader.swift
//  HS-APP
//
//  Created by Samuel Esserman on 6/1/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class HomePageHeader: UICollectionReusableView {
    
    let homeHeaderHorizontalController = HomeHeaderHorizontalController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(homeHeaderHorizontalController.view)
        homeHeaderHorizontalController.view.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
