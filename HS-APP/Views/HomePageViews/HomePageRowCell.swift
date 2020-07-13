//
//  HomePageRowCell.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/29/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit



class HomePageRowCell: UICollectionViewCell {
    
    
    let imageView           = UIImageView(cornerRadius: 8)
    let nameLabel           = UILabel(text: "Product Name", font: .systemFont(ofSize: 20))
    let categoryLabel       = UILabel(text: "Category Name", font: .systemFont(ofSize: 13))
    let getButton           = UIButton(title: "Buy")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        imageView.backgroundColor           = .purple
        imageView.constrainWidth(
            constant: 64)
        imageView.constrainHeight(
            constant: 64)
        
        getButton.backgroundColor           = UIColor(white: 0.95, alpha: 1)
        getButton.constrainWidth(
            constant: 80)
        getButton.constrainHeight(
            constant: 32)
        getButton.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius        = 32 / 2
        
        
        let stackView = UIStackView(arrangedSubviews:
            [imageView,
             VerticalStackView(
                arrangedSubviews:
                [nameLabel,
                 categoryLabel],
                spacing: 4),
             getButton])
        
        stackView.spacing           = 16
        stackView.alignment         = .center
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
