//
//  HSTabBarController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/15/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class HSTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewControllers = [
            createNavController(viewController: HomePageCompositionalController(), title: "Home Page", imageName: "apps"),
            createNavController(viewController: UIViewController(), title: "Collection-Detail", imageName: "search"),
            createNavController(viewController: UIViewController(), title: "Media", imageName: "today_icon"),
        ]
    }
    
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
        let navController                               = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles  = true
        viewController.navigationItem.title             = title
        viewController.view.backgroundColor             = .white
        navController.tabBarItem.title                  = title
        navController.tabBarItem.image                  = UIImage(named: imageName)
        
        return navController
    }
}
