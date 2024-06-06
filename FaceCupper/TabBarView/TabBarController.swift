//
//  TabBarController.swift
//  FaceCupper
//
//  Created by Admin on 6.05.24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var viewModel: TabBarViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        title = "Tabbar"
        tabBar.tintColor = .systemIndigo
        tabBar.backgroundColor = .systemGray3
        tabBar.unselectedItemTintColor = .darkGray
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let title = item.title else { return }
        
        viewModel?.tabBarItemPressed(tabBar: title)
    }

}
