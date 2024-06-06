//
//  ViewController.swift
//  FaceCupper
//
//  Created by Admin on 13.04.24.
//

import UIKit
import SwiftUI

class LogInViewController: UIViewController {

    @IBOutlet private weak var loginButton: CustomButton!
    @IBOutlet private weak var usernameInputView: InputView!
    @IBOutlet private weak var passwordInputView: InputView!

    var viewModel: LogInViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.customTitle = "Login"
        loginButton.addTarget(self, action: #selector(logInButtonTap), for: .touchUpInside)
        usernameInputView.labelText = Constants.usernameLabelText
        usernameInputView.textFieldPlaceholder = Constants.usernameTextFieldPlaceholder
        usernameInputView.titleTextField.text = "oniqotlqvo@abv.bg"
        passwordInputView.labelText = Constants.passwordLabelText
        passwordInputView.textFieldPlaceholder = Constants.passwordTextFieldPlaceholder
        passwordInputView.titleTextField.text = "oniqotlqvo"
    }

    @objc private func logInButtonTap() {
        Task {
            await viewModel?.logInUser(userName: usernameInputView.titleTextField.text!, password: passwordInputView.titleTextField.text!)
        }
    }
//    @IBAction func loginButtonTap(_ sender: UIButton) {
//        Task {
//            await viewModel?.logInUser(userName: usernameInputView.titleTextField.text!, password: passwordInputView.titleTextField.text!)
//        }
//    }

}
