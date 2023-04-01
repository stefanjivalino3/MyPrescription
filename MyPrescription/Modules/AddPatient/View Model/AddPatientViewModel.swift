//  
//  AddPatientViewModel.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import Foundation
import UIKit

class AddPatientViewModel {

    private let service: AddPatientServiceProtocol

    private var model: [AddPatientModel] = [AddPatientModel]() {
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
    var selectedObject: AddPatientModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init(withAddPatient serviceProtocol: AddPatientServiceProtocol = AddPatientService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    func savePatientData(patientData: PatientDataModel) {
        let newItem = PatientItem(context: self.context)
        
        newItem.fullName = patientData.fullName
        newItem.birthDate = patientData.birthDate
        newItem.visitDate = patientData.visitDate
        newItem.desc = patientData.description
        newItem.prescription = patientData.prescription
        newItem.medicinePhoto = patientData.medicinePhoto
        
        do {
            try context.save()
        } catch {
            
        }
    }

}

extension AddPatientViewModel {

}
