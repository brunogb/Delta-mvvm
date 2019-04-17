//
//  UIEdgeInsets+Initializers.swift
//  Delta
//
//  Created by Bruno Bilescky on 14/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

extension UIEdgeInsets {

    init(left: CGFloat = 0, top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    
}
