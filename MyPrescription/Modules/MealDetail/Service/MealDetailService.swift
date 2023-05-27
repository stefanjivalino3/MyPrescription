//  
//  MealDetailService.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 26/05/23.
//

import Foundation
import Alamofire

class MealDetailService: MealDetailServiceProtocol {
    
    func getMealDetail(id: String, onSuccess: @escaping (MealDetailModel) -> Void, onFailure: @escaping ((Error)) -> ()) {
        let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            interceptor: nil
        ).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(MealDetailModel.self, from: data)
                    onSuccess(result)
                } catch {
                    onFailure(error)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

class MealDetailMockService: MealDetailServiceProtocol {
    func getMealDetail(id: String, onSuccess: @escaping (MealDetailModel) -> Void, onFailure: @escaping ((Error)) -> ()) {
        let response = MealDetailModel(meals: [
            MealDetail(idMeal: "1",
                       strMeal: "Ayam Goreng Mentega",
                       strCategory: "Chicken",
                       strArea: "Indonesian",
                       strInstructions: "Test Instruction",
                       strMealThumb: "www.test.com",
                       strIngredient1: "Ayam",
                       strIngredient2: "Kecap",
                       strIngredient3: "Bawang",
                       strIngredient4: "Sambal",
                       strIngredient5: nil,
                       strIngredient6: nil,
                       strIngredient7: nil,
                       strIngredient8: nil,
                       strIngredient9: nil,
                       strIngredient10: nil,
                       strIngredient11: nil,
                       strIngredient12: nil,
                       strIngredient13: nil,
                       strIngredient14: nil,
                       strIngredient15: nil,
                       strIngredient16: nil,
                       strIngredient17: nil,
                       strIngredient18: nil,
                       strIngredient19: nil,
                       strIngredient20: nil,
                       strMeasure1: "1 Potong",
                       strMeasure2: "2 Sendok",
                       strMeasure3: "5 Siung",
                       strMeasure4: "2 Sendok",
                       strMeasure5: nil,
                       strMeasure6: nil,
                       strMeasure7: nil,
                       strMeasure8: nil,
                       strMeasure9: nil,
                       strMeasure10: nil,
                       strMeasure11: nil,
                       strMeasure12: nil,
                       strMeasure13: nil,
                       strMeasure14: nil,
                       strMeasure15: nil,
                       strMeasure16: nil,
                       strMeasure17: nil,
                       strMeasure18: nil,
                       strMeasure19: nil,
                       strMeasure20: nil)
        ])
        
        onSuccess(response)
    }
    
    
}
