//
//  UIView+Layout.swift
//  Delta
//
//  Created by Bruno Bilescky on 13/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    func alignInsideSuperview(insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) -> [NSLayoutConstraint] {
        guard let superview = self.superview else { return [] }
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        if edges.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top))
        }
        if edges.contains(.left) {
            constraints.append(leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left))
        }
        if edges.contains(.right) {
            constraints.append(superview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right))
        }
        if edges.contains(.bottom) {
            constraints.append(superview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom))
        }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
}
