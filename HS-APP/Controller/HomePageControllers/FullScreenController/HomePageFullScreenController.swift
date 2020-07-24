//
//  HomePageFullScreenController.swift
//  HS-APP
//
//  Created by Samuel Esserman on 7/24/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class HomePageFullScreenController: UIViewController {
    
    var dismissHandler: (() -> ())?
    var modelItem: GalleryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        setupCloseButton()
        setupImage()
    
    }

    let image = UIImageView()
    fileprivate func setupImage() {
        view.addSubview(image)
        image.sd_setImage(with: URL(string: modelItem!.imageUrl))
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -60, right: 16), size: .init(width: 0, height: 100))
        
    }
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "apps"), for: .normal)
        return button
    }()
    
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(
                top: 12,
                left: 0,
                bottom: 0,
                right: 0),
            size: .init(
                width: 80,
                height: 40))
        
        closeButton.addTarget(
            self,
            action: #selector(handleDismiss),
            for: .touchUpInside)
    }
    
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
}
