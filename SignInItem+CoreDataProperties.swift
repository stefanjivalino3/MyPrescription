//
//  SignInItem+CoreDataProperties.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//
//

import Foundation
import CoreData


extension SignInItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SignInItem> {
        return NSFetchRequest<SignInItem>(entityName: "SignInItem")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var userId: String?
    @NSManaged public var lastName: String?

}

extension SignInItem : Identifiable {

}
