//
//  PatientItem+CoreDataProperties.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//
//

import Foundation
import CoreData


extension PatientItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientItem> {
        return NSFetchRequest<PatientItem>(entityName: "PatientItem")
    }

    @NSManaged public var birthDate: Date?
    @NSManaged public var desc: String?
    @NSManaged public var fullName: String?
    @NSManaged public var medicinePhoto: Data?
    @NSManaged public var prescription: String?
    @NSManaged public var visitDate: Date?

}

extension PatientItem : Identifiable {

}
