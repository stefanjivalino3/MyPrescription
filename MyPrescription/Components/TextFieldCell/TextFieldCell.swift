//
//  TextFieldCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func getValue(for cell: TextFieldCell, value: String)
}

class TextFieldCell: UITableViewCell, UITextFieldDelegate {
    var didCheckEditing: (() -> ())?
    weak var delegate: TextFieldCellDelegate?
    var indexPath: IndexPath?

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        inputTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        inputTextField.delegate = self
    }
    
    func configure(title: String, placeHolder: String) {
        titleLabel.text = title
        inputTextField.placeholder = placeHolder
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        delegate?.getValue(for: self, value: "\(inputTextField.text ?? "")")
    }
    
    @IBAction func didEndEditing(_ sender: Any) {
        didCheckEditing?()
    }
}
