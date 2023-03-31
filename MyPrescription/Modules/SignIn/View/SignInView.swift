//  
//  SignInView.swift
//  MyPrescription
//
//  Created by Stefan Jivalino on 31/03/23.
//

import AuthenticationServices
import UIKit
import SnapKit

class SignInView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var logoImageView: UIImageView!
    

    // VARIABLES HERE
    var viewModel = SignInViewModel()
    private let signInButton = ASAuthorizationAppleIDButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.addSignInButton()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
//        signInButton.center = view.center
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
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
    
    private func addSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc func didTapSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    
}

extension SignInView: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
        
    }
            
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            viewModel.saveUserData(userId: credentials.user,
                                   firstName: credentials.fullName?.givenName ?? "",
                                   lastName: credentials.fullName?.familyName ?? "")
            let vc = PatientPageView()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
        
    }
}

extension SignInView: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
}


