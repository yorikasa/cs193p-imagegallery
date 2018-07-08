//
//  ImageItem.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/07.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import UIKit

struct ImageItem {
    var imageSize: CGSize
    var aspectRatio: CGFloat {
        return  imageSize.height / imageSize.width
    }
    var url: URL
    var createdAt: Date
    
    init(size: CGSize, url: String) {
        imageSize = size
        self.url = URL.init(string: "string")!
        createdAt = Date()
    }
    
    init() {
        imageSize = CGSize(width: 100, height: 100)
        self.url = URL.init(string: "url")!
        createdAt = Date()
    }
}

extension ImageItem: Equatable {
    static func == (lhs: ImageItem, rhs: ImageItem ) -> Bool {
        if lhs.createdAt == rhs.createdAt {
            return true
        } else {
            return false
        }
    }
}
