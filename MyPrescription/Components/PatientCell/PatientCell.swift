//
//  PatientCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit

class PatientCell: UITableViewCell {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var visitDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(name: String, birthdate: Date, visitdate: Date) {
        fullName.text = name
        birthDate.text = "Birth Date: \(birthdate.dateOnlyString)"
        visitDate.text = "Visit Date: \(visitdate.dateToFullDayString)"
    }
    
}
