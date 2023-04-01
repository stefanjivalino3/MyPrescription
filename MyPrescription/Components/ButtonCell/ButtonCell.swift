//
//  ButtonCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonTitle: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var didSubmit: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonView.layer.cornerRadius = 12
    }
    
    @IBAction func didSaveTapped(_ sender: Any) {
        didSubmit?()
    }
}
