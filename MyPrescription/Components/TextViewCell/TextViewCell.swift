//
//  TextViewCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit

protocol TextViewCellDelegate: AnyObject {
    func getValue(for cell: TextViewCell, value: String)
}

class TextViewCell: UITableViewCell, UITextViewDelegate {
    weak var delegate: TextViewCellDelegate?
    var indexPath: IndexPath?
    var placeHolderString: String = ""
    var didCheckEditing: (() -> ())?
    
    @IBOutlet weak var textViewBg: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
        textViewBg.layer.borderWidth = 1
        textViewBg.layer.borderColor = UIColor.systemGray6.cgColor
        textViewBg.layer.cornerRadius = 12
    }
    
    func configure(title: String, placeHolder: String) {
        titleLabel.text = title
        
        textView.text = placeHolder
        placeHolderString = placeHolder
        textView.textColor = UIColor.lightGray
    }
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.getValue(for: self, value: "\(textView.text ?? "")")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolderString
            textView.textColor = UIColor.lightGray
        }
        didCheckEditing?()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
}
