//
//  Gallery.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/05.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import Foundation

class Gallery{
    var status = Status.active
    var name: String
    var collection: [ImageItem]
    var id: Int
    
    enum Status {
        case active
        case deleted
    }
    
    static var idDefault = 0
    static func idGenerator() -> Int {
        idDefault += 1
        return idDefault
    }
    
    init(name: String) {
        self.status = Status.active
        self.name = name
        self.collection = []
        self.id = Gallery.idGenerator()
    }
}

extension Gallery: Equatable {
    static func == (lhs: Gallery, rhs: Gallery) -> Bool {
        return lhs.id == rhs.id ? true : false
    }
}
