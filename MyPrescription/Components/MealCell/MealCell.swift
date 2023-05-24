//
//  MealCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 25/05/23.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealDescLabel: UILabel!
    @IBOutlet weak var mealImageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        mealImageHeight.constant = UIScreen.main.bounds.size.width
    }
    
    func configure(mealTitle: String, mealDesc: String) {
        mealTitleLabel.text = mealTitle
        mealDescLabel.text = mealDesc
    }
    
}
