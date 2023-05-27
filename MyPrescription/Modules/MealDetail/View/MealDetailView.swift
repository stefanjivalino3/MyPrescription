//  
//  MealDetailView.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 26/05/23.
//

import UIKit

class MealDetailView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = MealDetailViewModel()
    var mealId: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupTableView()
        
        viewModel.getMealDetail(id: mealId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNIB(with: MealDetailCell.self)
        tableView.registerNIB(with: MealDetailGroupCell.self)
        tableView.registerNIB(with: MealDetailInstructionCell.self)
    }
    
    fileprivate func setupViewModel() {

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
            self?.tableView.reloadData()
        }

    }
    
}

extension MealDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredients.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueCell(with: MealDetailCell.self)!
            cell.selectionStyle = .none
            
            cell.configureCell(
                imageUrl: viewModel.mealDetailData.meals?.first?.strMealThumb ?? "",
                title: viewModel.mealDetailData.meals?.first?.strMeal ?? "",
                cuisine: viewModel.mealDetailData.meals?.first?.strArea ?? "",
                category: viewModel.mealDetailData.meals?.first?.strCategory ?? "")
            
            return cell
        }
        else if indexPath.row == viewModel.ingredients.count + 1 {
            let cell = tableView.dequeueCell(with: MealDetailInstructionCell.self)!
            cell.selectionStyle = .none
            
            cell.instructionLabel.text = viewModel.mealDetailData.meals?.first?.strInstructions?.html2String
            return cell
        }
        else {
            let cell = tableView.dequeueCell(with: MealDetailGroupCell.self)!
            cell.selectionStyle = .none
            
            cell.groupLabel.text = "\(viewModel.measure[indexPath.row - 1]) \(viewModel.ingredients[indexPath.row - 1])"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


