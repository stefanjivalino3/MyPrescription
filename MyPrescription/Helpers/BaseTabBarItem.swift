//
//  BaseTabBarItem.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 31/03/23.
//

import UIKit

class BaseTabBarItem: UITabBarItem {
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 5))], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 5))], for: .selected)
        titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -0)
    }
}
