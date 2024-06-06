//
//  TabBarCoordinator.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import UIKit

protocol TabBarCoordinatorProtocol: NSObject {
    func tabBarItemClicked(itemName: String)
}

class TabBarCoordinator: Coordinator, TabBarCoordinatorProtocol {
    
    private var window: UIWindow
    private let pages: [TabBarPage] = [.face, .photos, .profile]
        .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
        identifier = "tabBarCoordinatorId"
        parentCoordinator?.childCoordinators.removeAll {$0.identifier == "loginCoordinatorId"}
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        guard let tabBarController = TabBarController.initFromStoryBoard() else { return }
        
        window.rootViewController = tabBarController
        tabBarController.viewModel = TabBarViewModel(coordinator: self)
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.face.pageOrderNumber()
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageIcon(),
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .face:
            let faceMainCoordinator = FaceMainCoordinator(navController: navController)
            parentCoordinator?.addChildCoordinator(faceMainCoordinator)
            faceMainCoordinator.start()
        case .photos:
            let photosMainCoordinator = PhotoMainCoordinator(navController: navController)
            parentCoordinator?.addChildCoordinator(photosMainCoordinator)
            photosMainCoordinator.start()
        case .profile:
            let profileCoordinator = ProfileCoordinator(navController: navController)
            parentCoordinator?.addChildCoordinator(profileCoordinator)
            profileCoordinator.start()
        }
        
        return navController
    }
    
    func tabBarItemClicked(itemName: String) {
        
    }
    
}
