import UIKit

//MARK: - AppCoordinatorProtocol
protocol AppCoordinatorProtocol: AnyObject {
    func loadLogInPage()
    func pushToTabBarController()
}

class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    
    //MARK: - Properties
    private var rootNavController: UINavigationController
    private var window: UIWindow
        
    //MARK: - Initializer
    init(rootNavController: UINavigationController, window: UIWindow) {
        self.rootNavController = rootNavController
        self.window = window
    }

    //MARK: - Methods
    override func start() {
        identifier = Constants.appCoordinatorIdentifier
        parentCoordinator = self
        showLoginFlow()
    }
    
    func loadLogInPage() {
        rootNavController.viewControllers.removeAll()
        removeAllChildCoordinators()
        showLoginFlow()
    }
    
    func pushToTabBarController() {
        let tabBarCoordinator = TabBarCoordinator(window: window)
        
        parentCoordinator?.addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
    private func showLoginFlow() {
        let logInCoordinator = LogInCoordinator(navController: rootNavController)
        
        parentCoordinator?.addChildCoordinator(logInCoordinator)
        logInCoordinator.start()
    }
}
