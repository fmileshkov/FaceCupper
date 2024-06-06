//
//  AddTextViewModel.swift
//  FaceCupper
//
//  Created by Admin on 10.05.24.
//

import Foundation

protocol ProfileViewModelProtocol {
    
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    weak var coordinator: ProfileCoordinatorProtocol?
    
    init(coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
}
