//
//  LogInViewModel.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import Foundation

protocol LogInViewModelProtocol: AnyObject {
    func logInUser(userName: String, password: String) async
}

class LogInViewModel: LogInViewModelProtocol {

    private weak var coordinator: LogInCoordinatorProtocol?
    private let firebase: FirestoreServiceProtocol?
    
    init(coordinator: LogInCoordinatorProtocol, firebase: FirestoreServiceProtocol) {
        self.coordinator = coordinator
        self.firebase = firebase
    }
    
    @MainActor func logInUser(userName: String, password: String) async {
        do {
           try await firebase?.signIn(userName, password)
            
            guard firebase?.currentUser != nil else { return }
            
                self.coordinator?.authUser(logInResult: true)
        } catch {
                self.coordinator?.authUser(logInResult: false)
        }
    }
    
}
