//  
//  PatientPageViewModel.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import Foundation
import UIKit

class PatientPageViewModel {

    private let service: PatientPageServiceProtocol

    var patientData = [PatientItem]()
    private var model: [PatientPageModel] = [PatientPageModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    var count: Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
    var selectedObject: PatientPageModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init(withPatientPage serviceProtocol: PatientPageServiceProtocol = PatientPageService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    func getPatientList() {
        do {
            let data = try context.fetch(PatientItem.fetchRequest())
            patientData = data.reversed()
            didGetData?()
            
        }
        catch {}
    }
    
    func deletePatient(patient: PatientItem) {
        context.delete(patient)
        do {
            try context.save()
        } catch {}
    }

    

}

extension PatientPageViewModel {

}
