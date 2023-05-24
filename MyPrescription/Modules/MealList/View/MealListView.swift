//  
//  MealListView.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 24/05/23.
//

import UIKit

class MealListView: UIViewController {

    // OUTLETS HERE

    // VARIABLES HERE
    var viewModel = MealListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    fileprivate func setupViewModel() {
        self.viewModel.getMealList()
        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                 print("DATA READY")
            }
        }

        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }

        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }

        self.viewModel.didGetData = { [weak self] in
            print(self?.viewModel.mealData ?? [])
        }

    }
    
}


