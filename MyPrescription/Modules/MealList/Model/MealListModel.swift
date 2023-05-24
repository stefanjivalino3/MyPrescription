//  
//  MealListModel.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 24/05/23.
//

import Foundation

struct MealListModel: Codable {
    var meals: [Meals]?
}

struct Meals: Codable {
    var idMeal:String
    var strMeal:String
    var strCategory: String
    var strMealThumb: String
}

