//
//  ProductCategory.swift
//  HS-APP
//
//  Created by Samuel Esserman on 6/1/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

struct Category: Decodable {
    let category: String
    let products: [Product]
}
