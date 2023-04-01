//  
//  AddPatientView.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 01/04/23.
//

import UIKit

class AddPatientView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = AddPatientViewModel()
    var patientData =   PatientDataModel()
    var patientSavedData = PatientItem()
    var photoImage: UIImage = UIImage(systemName: "camera") ?? UIImage()
    var isButtonEnabled = false
    var isDetailPage = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.setupViewModel()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if isDetailPage == false {
            navigationItem.title = "Add Patient"
        } else {
            navigationItem.title = "Patient Detail"
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNIB(with: TextFieldCell.self)
        tableView.registerNIB(with: DatePickerCell.self)
        tableView.registerNIB(with: TextViewCell.self)
        tableView.registerNIB(with: PhotoCell.self)
        tableView.registerNIB(with: ButtonCell.self)
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

        self.viewModel.didGetData = {
            // update UI after get data
        }

    }
    
    private func checkDataFilled() {
        if patientData.fullName != "" && patientData.description != "" && patientData.prescription != "" {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
        
        let index = IndexPath(row: 6, section: 0)
        tableView.reloadRows(at: [index], with: .none )
    }
    
}

extension AddPatientView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDetailPage == true {
            return 6
        } else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueCell(with: TextFieldCell.self)!
            cell.selectionStyle = .none
            cell.configure(title: "Full Name")
            cell.delegate = self
            cell.indexPath = indexPath
            
            cell.didCheckEditing = { [weak self] in
                self?.checkDataFilled()
            }
            
            if isDetailPage == true {
                cell.inputTextField.isUserInteractionEnabled = false
                cell.inputTextField.text = patientSavedData.fullName
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueCell(with: DatePickerCell.self)!
            cell.selectionStyle = .none
            cell.configure(title: "Birth Date")
            cell.delegate = self
            cell.indexPath = indexPath
            
            cell.datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -90, to: Date())
            cell.datePicker.maximumDate = Date()
            
            if isDetailPage == true {
                cell.datePicker.isUserInteractionEnabled = false
                cell.datePicker.date = patientSavedData.birthDate ?? Date()
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueCell(with: DatePickerCell.self)!
            cell.selectionStyle = .none
            cell.configure(title: "Visit Date")
            
            cell.datePicker.minimumDate = Date()
            cell.datePicker.maximumDate = Date()
            cell.datePicker.isUserInteractionEnabled = false
            
            if isDetailPage == true {
                cell.datePicker.isUserInteractionEnabled = false
                cell.datePicker.date = patientSavedData.visitDate ?? Date()
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueCell(with: TextViewCell.self)!
            cell.selectionStyle = .none
            cell.delegate = self
            cell.indexPath = indexPath
            cell.configure(title: "Description")
            cell.didCheckEditing = { [weak self] in
                self?.checkDataFilled()
            }
            
            if isDetailPage == true {
                cell.textView.isUserInteractionEnabled = false
                cell.textView.text = patientSavedData.desc
            }
            
            return cell
        case 4:
            let cell = tableView.dequeueCell(with: TextViewCell.self)!
            cell.selectionStyle = .none
            cell.delegate = self
            cell.indexPath = indexPath
            cell.configure(title: "Prescription")
            cell.didCheckEditing = { [weak self] in
                self?.checkDataFilled()
            }
            
            if isDetailPage == true {
                cell.textView.isUserInteractionEnabled = false
                cell.textView.text = patientSavedData.prescription
            }
            
            return cell
        case 5:
            let cell = tableView.dequeueCell(with: PhotoCell.self)!
            cell.selectionStyle = .none
            cell.delegate = self
            cell.indexPath = indexPath
            cell.photoImageView.image = photoImage
            
            if isDetailPage == true {
                cell.photoImageView.image = UIImage(data: patientSavedData.medicinePhoto ?? Data())
                cell.buttonView.isHidden = true
            }
            
            cell.didOpenPhoto = { [weak self] in
                if cell.photoImageView.image != UIImage(systemName: "camera") {
                    let vc = OpenPhotoView()
                    vc.photoImage = cell.photoImageView.image
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            }
            
            
            
            return cell
        default:
            let cell = tableView.dequeueCell(with: ButtonCell.self)!
            cell.selectionStyle = .none
            
            cell.didSubmit = { [weak self] in
                self?.viewModel.savePatientData(patientData: self?.patientData ?? PatientDataModel())
                
                self?.navigationController?.popToRootViewController(animated: true)
            }
            
            if isButtonEnabled == true {
                cell.buttonTitle.textColor = UIColor.white
                cell.buttonView.backgroundColor = UIColor.black
                cell.submitButton.isUserInteractionEnabled = true
            } else {
                cell.buttonTitle.textColor = UIColor.systemGray4
                cell.buttonView.backgroundColor = UIColor.systemGray2
                cell.submitButton.isUserInteractionEnabled = false
            }
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 {
            return 200
        } else {
            return 80
        }
        
    }
}

extension AddPatientView: TextFieldCellDelegate, TextViewCellDelegate, PhotoCellDelegate, DatePickerCellDelegate {
    func getValue(for cell: TextFieldCell, value: String) {
        if cell.indexPath?.row == 0 {
            patientData.fullName = value
        }
    }
    
    func getValue(for cell: TextViewCell, value: String) {
        if cell.indexPath?.row == 3 {
            patientData.description = value
        } else if cell.indexPath?.row == 4 {
            patientData.prescription = value
        }
    }
    
    func openImagePicker(for cell: PhotoCell) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func getValue(for cell: DatePickerCell, value: Date) {
        if cell.indexPath?.row == 1 {
            patientData.birthDate = value.convertedDate
        }
    }
}

extension AddPatientView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        photoImage = image
        patientData.medicinePhoto = image.jpegData(compressionQuality: 1) ?? Data()
        
        let index = IndexPath(row: 5, section: 0)
        tableView.reloadRows(at: [index], with: .none)
    }
}



