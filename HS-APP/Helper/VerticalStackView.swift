//
//  VerticalStackView.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/15/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView],
         spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach({addArrangedSubview($0)})
        
        self.spacing    = spacing
        self.axis       = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
