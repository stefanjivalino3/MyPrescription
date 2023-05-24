//  
//  MealListView.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 24/05/23.
//

import UIKit

class MealListView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // VARIABLES HERE
    var viewModel = MealListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupView()
        self.setupTableView()
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
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

    }
    
    func setupView() {
        self.searchTextField.delegate = self
        self.searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        self.searchView.layer.cornerRadius = 12
        self.searchView.layer.borderWidth = 1
        self.searchView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.registerNIB(with: MealCell.self)
    }
    
}

extension MealListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealData.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: MealCell.self)!
        cell.selectionStyle = .none
        
        cell.configure(mealTitle: viewModel.mealData.meals?[indexPath.row].strMeal ?? "",
                       mealDesc: viewModel.mealData.meals?[indexPath.row].strCategory ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension MealListView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = searchTextField.text,
        let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 1
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        self.viewModel.getMealList(search: searchTextField.text ?? "")
    }
}


