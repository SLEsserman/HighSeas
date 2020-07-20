//
//  HTMLConverter.swift
//  HS-APP
//
//  Created by Samuel Esserman on 6/15/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import UIKit

func removeHTMLTags(html: String) -> String {
    return html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
}
