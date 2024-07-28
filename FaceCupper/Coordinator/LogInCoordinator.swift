import UIKit

protocol LogInCoordinatorProtocol: NSObject {
    func authUser(logInResult: Bool)
}

class LogInCoordinator: Coordinator, LogInCoordinatorProtocol {
    
    private var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    deinit {
        navController.viewControllers.removeAll()
    }
    
    override func start() {
        guard let logInVC = LogInViewController.initFromStoryBoard() else { return }
        
        identifier = Constants.loginCoordinatorIdentifier
        logInVC.viewModel = LogInViewModel(coordinator: self, firebase: FirestoreService())
        navController.pushViewController(logInVC, animated: false)
    }
    
    func authUser(logInResult: Bool) {
        guard let appCoordinator: AppCoordinatorProtocol = firstParent(of: AppCoordinator.self) else { return }
        
        switch logInResult {
        case true:
            appCoordinator.pushToTabBarController()
        case false:
            // Inform the user that the credentials are not accepted
            print("Cant Login")
        }
    }
}
