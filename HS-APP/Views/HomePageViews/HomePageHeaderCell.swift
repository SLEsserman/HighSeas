//
//  HomePageHeaderCell.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/27/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class HomePageHeaderCell: UICollectionViewCell {
    
    
//    let companyLabel = UILabel(
//        text: "HighSeas",
//        font: .boldSystemFont(ofSize: 12))
    var product: GalleryItem! {
           didSet {
                titleLabel.text = product.title
                imageView.sd_setImage(with: URL(string: product.imageUrl))
           }
    }
    
    let titleLabel = UILabel(
        text: "Don't settle down and sit in one place. Move around, be nomadic, make each day a new horizon",
        font: .systemFont(ofSize: 24))
    
    let imageView = UIImageView(cornerRadius: 8)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
//        companyLabel.textColor      = .blue
        titleLabel.numberOfLines    = 2
        
        let stackView = VerticalStackView(arrangedSubviews: [
            titleLabel,
            imageView
        ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(
            top: 16,
            left: 0,
            bottom: 0,
            right: 0))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
