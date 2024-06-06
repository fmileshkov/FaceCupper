//
//  FaceMainCoordinator.swift
//  FaceCupper
//
//  Created by Admin on 10.05.24.
//

import UIKit

protocol FaceMainCoordinatorProtocol: NSObject {
    
}

class FaceMainCoordinator: Coordinator, FaceMainCoordinatorProtocol {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        guard let faceVC = FaceMainViewController.initFromStoryBoard() else { return }
        
        faceVC.viewModel = FaceMainViewModel(coordinator: self)
        navController.pushViewController(faceVC, animated: false)
    }
    
    
}
