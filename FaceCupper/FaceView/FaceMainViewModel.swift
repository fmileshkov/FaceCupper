//
//  FaceMainViewModel.swift
//  FaceCupper
//
//  Created by Admin on 10.05.24.
//

import Foundation

protocol FaceMainViewModelProtocol {
    
}


class FaceMainViewModel: FaceMainViewModelProtocol {
    
    weak var coordinator: FaceMainCoordinatorProtocol?
    
    init(coordinator: FaceMainCoordinator) {
        self.coordinator = coordinator
    }
    
    
}
