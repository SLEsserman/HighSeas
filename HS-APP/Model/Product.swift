//
//  ProductsGroup.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/18/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import Foundation

struct Products: Decodable {
let product: [Product]

}

struct Product: Decodable, Hashable {
let id: Int
let name: String
let short_description: String
let price: String
let images: [ProductImage]
}

struct ProductImage: Decodable, Hashable {
let id: Int
let src: String
let name: String
let alt: String?
}
