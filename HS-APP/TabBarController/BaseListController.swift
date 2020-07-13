//
//  BaseListController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/15/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
