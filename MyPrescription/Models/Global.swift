//
//  Global.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 31/03/23.
//

import Foundation

struct Global {
    static var isLoggedIn: Bool {
        get {
            if let newUser = UserDefaults.standard.object(forKey: "isLoggedIn") {
                return newUser as! Bool
            } else {
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
        }
    }
}
