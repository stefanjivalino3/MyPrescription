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

    func getMealList(onSuccess: @escaping(MealListModel) -> Void, onFailure: @escaping((Error)) -> ()) {

        let url = "https://www.themealdb.com/api/json/v1/1/search.php?f=a"
        
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
                do {
                    let result = try JSONDecoder().decode(MealListModel.self, from: data!)
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
