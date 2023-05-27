//
//  MealCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 25/05/23.
//

import UIKit

class MealCell: UITableViewCell, ZoomableTableViewCell {
    @IBOutlet private weak var mediaView: ZoomableView!
    
    var zoomableView: ZoomableView {
        return mediaView
    }

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealDescLabel: UILabel!
    @IBOutlet weak var mealImageHeight: NSLayoutConstraint!
    @IBOutlet weak var viewButton: UIButton!
    
    var didTapViewRecipe: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        viewButton.layer.cornerRadius = 8
        bgView.layer.cornerRadius = 16
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.black.cgColor
        
        zoomableView.sourceView = mealImageView
        zoomableView.isZoomable = true
    }
    
    func configure(mealTitle: String, mealDesc: String, mealImage: String) {
        mealTitleLabel.text = mealTitle
        mealDescLabel.text = "Category: \(mealDesc)"
        mealImageView.showImageFromUrl(url: mealImage)
    }
    
    @IBAction func didTappedViewRecipe(_ sender: Any) {
        didTapViewRecipe?()
    }
    
}
