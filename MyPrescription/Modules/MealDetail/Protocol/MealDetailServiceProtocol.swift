//  
//  MealDetailServiceProtocol.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 26/05/23.
//

import Foundation

protocol MealDetailServiceProtocol {

    func getMealDetail(id: String, onSuccess: @escaping(MealDetailModel) -> Void, onFailure: @escaping((Error)) -> ())

}
