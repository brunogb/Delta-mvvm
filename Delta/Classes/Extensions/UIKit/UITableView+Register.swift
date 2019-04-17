//
//  UITableView+Register.swift
//  Delta
//
//  Created by Bruno Bilescky on 14/04/2019.
//  Copyright © 2019 Bruno Bilescky. All rights reserved.
//

import UIKit

private var registeredIdentifiersReferenceKey = 0
extension UITableView {

    var registeredIdentifiers: [String] {
        get {
            if let value = objc_getAssociatedObject(self, &registeredIdentifiersReferenceKey) as? [String] {
                return value
            }
            return []
        }
        set {
            objc_setAssociatedObject(self, &registeredIdentifiersReferenceKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func registerAndDequeue<T: TableViewDequeableModel>(cellFor item: T, at indexPath: IndexPath)-> UITableViewCell {
        let identifier = String(describing: item.dequeueClass)
        if !registeredIdentifiers.contains(identifier) {
            register(item.dequeueClass, forCellReuseIdentifier: identifier)
            registeredIdentifiers.append(identifier)
        }
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
    
    
}
