//  
//  MealDetailViewModel.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 26/05/23.
//

import Foundation

class MealDetailViewModel {

    private let service: MealDetailServiceProtocol

    private var model: [MealDetailModel] = [MealDetailModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    /// Count your data in model
    var count: Int = 0
    var mealDetailData = MealDetailModel()
    var ingredients: [String] = []
    var measure: [String] = []

    //MARK: -- Network checking

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    /// Define selected model
    var selectedObject: MealDetailModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init(withMealDetail serviceProtocol: MealDetailServiceProtocol = MealDetailService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    //MARK: -- Example Func
    func getMealDetail(id: String) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            service.getMealDetail(id: id) {  [weak self] result in
                self?.mealDetailData = result
                var listIngredients: [String] = []
                var listMeasure: [String] = []

                listIngredients.append(result.meals?.first?.strIngredient1 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient2 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient3 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient4 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient5 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient6 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient7 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient8 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient9 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient10 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient11 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient12 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient13 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient14 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient15 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient16 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient17 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient18 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient19 ?? "")
                listIngredients.append(result.meals?.first?.strIngredient20 ?? "")
    
                listMeasure.append(result.meals?.first?.strMeasure1 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure2 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure3 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure4 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure5 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure6 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure7 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure8 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure9 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure10 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure11 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure12 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure13 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure14 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure15 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure16 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure17 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure18 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure19 ?? "")
                listMeasure.append(result.meals?.first?.strMeasure20 ?? "")
                
                self?.ingredients = listIngredients.filter { $0 != "" }
                self?.measure = listMeasure.filter { $0 != "" }
                
                self?.didGetData?()
            } onFailure: { [weak self] error in
                guard self != nil else {return}
                print(error.localizedDescription)
            }
        default:
            break
        }
    }

}

extension MealDetailViewModel {

}
