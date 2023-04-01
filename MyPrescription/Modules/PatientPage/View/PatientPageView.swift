//  
//  PatientPageView.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit

class PatientPageView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = PatientPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.viewModel.getPatientList()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.viewModel.getPatientList()
        self.tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNIB(with: PatientCell.self)
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
    
    @IBAction func addPatientTapped(_ sender: Any) {
        let vc = AddPatientView()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension PatientPageView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.patientData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: PatientCell.self)!
        cell.selectionStyle = .none
        cell.configure(name: viewModel.patientData[indexPath.row].fullName ?? "",
                       birthdate: viewModel.patientData[indexPath.row].birthDate ?? Date(),
                       visitdate: viewModel.patientData[indexPath.row].visitDate ?? Date())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddPatientView()
        vc.isDetailPage = true
        vc.patientSavedData = viewModel.patientData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        viewModel.deletePatient(patient: viewModel.patientData[indexPath.row])
        viewModel.patientData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}



