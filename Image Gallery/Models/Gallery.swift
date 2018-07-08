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
    
    enum Status {
        case active
        case deleted
    }
}
