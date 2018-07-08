//
//  ImageItem.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/07.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import Foundation

struct ImageItem {
    let imageWidth: Int
    let imageHeight: Int
    var aspectRatio: Double {
        return  Double(imageHeight) / Double(imageWidth)
    }
    let url: URL
    
    // for testing
    var urlString: String = "sampleImage"
    
    init() {
        imageHeight = 10
        imageWidth = 10
        url = URL.init(string: "http://google.com")!
    }
}
