//
//  HomePageDetailCell.swift
//  HS-APP
//
//  Created by Samuel Esserman on 6/22/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class HomePageDetailCell: UICollectionViewCell {
    
    var products: Product! {
        didSet {
            nameLabel.text                  = products.name
            productInformation.text         = products.short_description
            productIconImageView.sd_setImage(with: URL(string: products?.images[0].src ?? ""))
            priceButton.setTitle(products.price, for: .normal)
        }
    }
    
    let productIconImageView        = UIImageView(cornerRadius: 16)
    let nameLabel                   = UILabel(text: "Product Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton                 = UIButton(title: "$25.00")
    let productInformation          = UILabel(text: "Details", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        productIconImageView.backgroundColor = .red
        productIconImageView.constrainWidth(constant: 140)
        productIconImageView.constrainHeight(constant: 140)
        
        priceButton.backgroundColor = .blue
        priceButton.constrainHeight(constant: 32)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.constrainWidth(constant: 80)
        
        let stackView = VerticalStackView(
            arrangedSubviews: [
                UIStackView(
                    arrangedSubviews: [
                        productIconImageView,
                        VerticalStackView(
                            arrangedSubviews: [
                                nameLabel,
                                UIStackView(
                                    arrangedSubviews: [
                                        priceButton,
                                        UIView()
                                ]),
                                UIView()
                        ], spacing: 12)
                ], customSpacing: 20),
                productInformation
        ], spacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(
            top: 20,
            left: 20,
            bottom: 20,
            right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
