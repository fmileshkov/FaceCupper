//
//  RegisterViewController.swift
//  FaceCupper
//
//  Created by Admin on 22.04.24.
//

import UIKit
import SwiftUI

class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var userEmailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var repeatPasswordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    
    private let firebase: FirestoreServiceProtocol = FirestoreService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let userEmail = userEmailTextField.text,
              let userPassword = passwordTextField.text else {
            return
        }
        
//        firebase.registerNewUser(userEmail, userPassword) { [weak self] userId, error in
//            guard error == nil,
//                  let userId else { return }
//
//            print(userId)
//        }
    }
    
}
