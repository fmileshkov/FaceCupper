import UIKit

protocol PhotoMainCoordinatorProtocol: NSObject {
    
}

class PhotoMainCoordinator: Coordinator, PhotoMainCoordinatorProtocol {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        guard let photoVC = PhotoMainViewController.initFromStoryBoard() else { return }

        photoVC.viewModel = PhotoMainViewModel(coordinator: self)
        navController.pushViewController(photoVC, animated: false)
    }
    
}
