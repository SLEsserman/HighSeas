//
//  Gallery.swift
//  HS-APP
//
//  Created by Samuel Esserman on 6/10/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import Foundation

struct GalleryItem: Decodable, Hashable {
    let title: String
    let imageUrl: String
}
