//  
//  MealListService.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 24/05/23.
//

import Foundation
import Alamofire

class MealListService: MealListServiceProtocol {
    // Call protocol function

    func getMealList(search: String, onSuccess: @escaping(MealListModel) -> Void, onFailure: @escaping((Error)) -> ()) {

        let url = "https://www.themealdb.com/api/json/v1/1/search.php?f=\(search)"
        
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
                    let result = try JSONDecoder().decode(MealListModel.self, from: data)
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

class MealListMockService: MealListServiceProtocol {
    func getMealList(search: String, onSuccess: @escaping (MealListModel) -> Void, onFailure: @escaping ((Error)) -> ()) {
        let response = MealListModel(meals: [
            Meals(idMeal: "1", strMeal: "Apple", strCategory: "Dessert", strMealThumb: "www.test.com"),
            Meals(idMeal: "3", strMeal: "Air", strCategory: "Dessert", strMealThumb: "www.test.com"),
            Meals(idMeal: "4", strMeal: "Arem", strCategory: "Dessert", strMealThumb: "www.test.com"),
            Meals(idMeal: "6", strMeal: "Arak", strCategory: "Dessert", strMealThumb: "www.test.com")
        ])
        
        onSuccess(response)
    }
    
    
}


