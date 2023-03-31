//  
//  SignInViewModel.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 31/03/23.
//

import Foundation
import UIKit

class SignInViewModel {

    private let service: SignInServiceProtocol

    private var model: [SignInModel] = [SignInModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var count: Int = 0

    //MARK: -- Network checking

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    /// Define selected model
    var selectedObject: SignInModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init(withSignIn serviceProtocol: SignInServiceProtocol = SignInService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    func saveUserData(userId: String, firstName: String, lastName: String) {
        let newItem = SignInItem(context: self.context)
        newItem.userId = userId
        newItem.firstName = firstName
        newItem.lastName = lastName
        
        do {
            try context.save()
        } catch {
            
        }
    }

}

extension SignInViewModel {

}
