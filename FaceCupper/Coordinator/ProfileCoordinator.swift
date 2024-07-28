import UIKit

protocol ProfileCoordinatorProtocol: NSObject {
    
}

class ProfileCoordinator: Coordinator, ProfileCoordinatorProtocol {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    override func start() {
        guard let profileVC = ProfileViewController.initFromStoryBoard() else { return }
        
        profileVC.viewModel = ProfileViewModel(coordinator: self)
        navController.pushViewController(profileVC, animated: false)
    }
    
}
