//
//  PhotoMainViewModel.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import Foundation

protocol PhotoMainViewModelProtocol {
    
}

class PhotoMainViewModel: PhotoMainViewModelProtocol {
    
    private weak var coordinator: PhotoMainCoordinatorProtocol?
    
    init(coordinator: PhotoMainCoordinator) {
        self.coordinator = coordinator
    }
}
