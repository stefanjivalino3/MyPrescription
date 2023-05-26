//  
//  MealListServiceProtocol.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 24/05/23.
//

import Foundation

protocol MealListServiceProtocol {
    
    func getMealList(search: String, onSuccess: @escaping(MealListModel) -> Void, onFailure: @escaping((Error)) -> ())

}
