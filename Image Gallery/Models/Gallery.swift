//
//  Gallery.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/05.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import Foundation

class Gallery {
    var status = Status.active
    var name: String
    var collection: [ImageItem]
    
    enum Status {
        case active
        case deleted
    }
    
    init(name: String) {
        self.status = Status.active
        self.name = name
        self.collection = []
    }
}
