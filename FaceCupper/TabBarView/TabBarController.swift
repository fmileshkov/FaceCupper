import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var viewModel: TabBarViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        title = Constants.tabBarControllerTitle
        tabBar.tintColor = .systemIndigo
        tabBar.backgroundColor = .systemGray3
        tabBar.unselectedItemTintColor = .darkGray
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let title = item.title else { return }
        
        viewModel?.tabBarItemPressed(tabBar: title)
    }

}
