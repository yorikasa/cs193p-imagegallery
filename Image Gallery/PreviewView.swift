//
//  PreviewView.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/06/20.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import UIKit

class PreviewView: UIView {
    
    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
    
}

