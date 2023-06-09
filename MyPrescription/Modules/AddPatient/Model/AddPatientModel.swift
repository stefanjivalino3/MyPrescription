//  
//  AddPatientModel.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import Foundation

struct AddPatientModel: Codable {
    
}

struct PatientDataModel {
    var fullName: String = ""
    var description: String = ""
    var prescription: String = ""
    var birthDate: Date = Date().convertedDate
    var visitDate: Date = Date().convertedDate
    var medicinePhoto: Data = Data()
    
    init() {}
}

