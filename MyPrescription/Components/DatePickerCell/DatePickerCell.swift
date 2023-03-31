//
//  DatePickerCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit

protocol DatePickerCellDelegate: AnyObject {
    func getValue(for cell: DatePickerCell, value: Date)
}

class DatePickerCell: UITableViewCell {
    weak var delegate: DatePickerCellDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.timeZone = TimeZone(secondsFromGMT: 0)
    }
    
    func configure(title: String) {
        titleLabel.text = title
        
    }
    
    @IBAction func datePickerDidChange(_ sender: Any) {
        delegate?.getValue(for: self, value: datePicker.date)
    }
}
