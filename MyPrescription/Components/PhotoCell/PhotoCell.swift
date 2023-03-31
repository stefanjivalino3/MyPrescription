//
//  PhotoCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit
protocol PhotoCellDelegate: AnyObject {
    func openImagePicker(for cell: PhotoCell)
}

class PhotoCell: UITableViewCell {
    weak var delegate: PhotoCellDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonView.layer.cornerRadius = 12
    }
    
    @IBAction func takePhotoTapped(_ sender: Any) {
        delegate?.openImagePicker(for: self)
    }
}
