//
//  MealDetailCell.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 26/05/23.
//

import UIKit

class MealDetailCell: UITableViewCell {
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(imageUrl: String, title: String, cuisine: String, category: String) {
        mealImageView.showImageFromUrl(url: imageUrl)
        
        titleLabel.text = title
        cuisineLabel.text = "Cuisine: \(cuisine)"
        categoryLabel.text = "Category: \(category)"
    }
    
    
    
}
