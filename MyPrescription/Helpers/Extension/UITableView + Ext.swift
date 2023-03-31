//
//  UITableView + Ext.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 31/03/23.
//

import Foundation
import UIKit

extension UITableView {
    func registerNIB(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: cellClass)) as? T
    }
}

