//
//  Gallery.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/05.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import Foundation

struct Gallery {
    var status = Status.active
    var name: String
    
    enum Status {
        case active
        case deleted
    }
    
    init(name: String) {
        self.status = Status.active
        self.name = name
    }
}
